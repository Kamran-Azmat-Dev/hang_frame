<template>
  <div class="w-full flex flex-col items-center upload-crop-step">
    <v-h3 v-if="isStandardUpload" class="text-center">
      Crop your <span class="italic">digital photo</span>
    </v-h3>
    <v-h3 v-if="!isStandardUpload" class="text-center">
      Choose the size of the digital print
    </v-h3>
    <v-p
      v-if="isStandardUpload"
      class="text-center"
      style="margin-top: 50px; font-size: 20px"
    >
      The area inside the crop tool is the area that will be printed.
    </v-p>
    <v-p v-if="!isStandardUpload" class="text-center" style="margin-top: 40px">
      Crop your photo (if required) and then select the size you would <br />
      like it printed? Available print sizes are based on your digital <br />
      photo's resolution.
    </v-p>
    <crop-digital-quality-summary
      v-if="isPhotoReady"
      class="w-full flex flex-col items-center mt-6"
      :cropped-size="croppedSize"
      :print-size="printSize"
    />
    <crop-loading-error-message v-else-if="isPhotoLoadingError" />
    <div class="w-full mt-16 grid md:grid-cols-12 md:gap-6">
      <crop-digital-step-label
        class="hidden md:flex md:items-center md:col-start-3 md:col-end-5"
        :number="1"
        label="Crop your image"
      />
      <div class="md:col-span-4 flex flex-col items-center">
        <div
          class="
            w-full
            max-w-70
            h-70
            sm:max-w-90 sm:h-90
            bg-white
            flex flex-col
          "
        >
          <img
            v-if="!isPhotoReady && !isPhotoLoadingError"
            src="~images/loading.gif"
            class="w-10 h-10 mx-auto mt-40"
          />
          <cropper
            v-if="photoUrl"
            class="my-auto"
            ref="cropper"
            :src="photoUrl"
            :stencil-props="stencilProps"
            :default-size="defaultSize"
            :resize-image="false"
            :check-orientation="false"
            @change="changeCropping"
            @ready="photoLoaded"
            @error="photoLoadingError"
          />
        </div>
      </div>
      <div class="md:col-span-3 flex flex-col">
        <crop-digital-preset-panel
          v-if="isCustomUpload"
          class="my-auto"
          :presets="cropPresets"
          :active-preset="activeCropPreset"
          @changeCropPreset="changeCropPreset"
        />
      </div>
    </div>
    <div class="w-full mt-12 grid md:grid-cols-12 md:gap-6">
      <crop-digital-step-label
        v-if="isCustomUpload"
        class="hidden md:flex md:items-center md:col-start-3 md:col-end-5"
        :number="2"
        label="Print size"
      />
      <div class="md:col-span-4 flex flex-col items-center">
        <crop-digital-print-size-select
          v-if="isCustomUpload"
          class="w-full max-w-90"
          :print-size-options="printSizeOptions"
          v-model="printSize"
          @selected="onPrintSizeSelected"
        />
      </div>
    </div>
    <crop-digital-dpi-error
      v-if="isPhotoReady && !isMatchingDpi"
      :is-matching-dpi-for-smallest-print-size="
        isMatchingDpiForSmallestPrintSize
      "
      class="mt-16"
    />
    <v-button
      class="w-full max-w-77 mt-16 flex flex-col items-center"
      :disabled="!isPhotoReady || !isMatchingDpi || isSaveInProgress"
      @click="chooseFrameClicked"
    >
      <div v-if="isSaveInProgress" class="flex mx-auto items-center">
        <img src="~images/loading.gif" class="w-4 h-4 mr-4" />
        Cropping...
      </div>
      <span v-else-if="isSaveError">Failed to save</span>
      <span v-else-if="isStandardUpload">Back to frame</span>
      <span v-else>{{ checkPath() ? "Back to frame" : "Choose a Frame" }}</span>
    </v-button>
    <v-button
      class="w-full max-w-77 mt-4"
      style-variant="secondary"
      @click="changePhotoClicked"
    >
      Change Photo
    </v-button>
  </div>
</template>

<script>
import { Cropper } from "vue-advanced-cropper";
import VH3 from "../../Atoms/VH3";
import VP from "../../Atoms/VP";
import VButton from "../../Atoms/VButton";
import CropLoadingErrorMessage from "../Crop/CropLoadingErrorMessage";
import CropDigitalQualitySummary from "./CropDigitalQualitySummary";
import CropDigitalStepLabel from "./CropDigitalStepLabel";
import CropDigitalPrintSizeSelect from "./CropDigitalPrintSizeSelect";
import CropDigitalPresetPanel from "./CropDigitalPresetPanel";
import CropDigitalDpiError from "./CropDigitalDpiError";
import {
  digitalUploadTypes,
  cropPresets,
  minSide,
  maxLongestSide,
  maxShortestSide,
  minDpi,
  inchToCm,
} from "../constants";
import { fetchUpload, saveUploadCrop } from "../../../lib/api/upload";
import "vue-advanced-cropper/dist/style.css";

const buildPrintSizeOption = (printSize) => {
  const cmWidth = parseFloat(printSize.width);
  const cmHeight = parseFloat(printSize.height);
  const cmLabel = `${cmWidth.toFixed(1)} x ${cmHeight.toFixed(1)}cm`;
  const inchToCm = 2.54;
  const inWidth = cmWidth / inchToCm;
  const inHeight = cmHeight / inchToCm;

  const inLabel = `${Math.round(inWidth)}" x ${Math.round(inHeight)}"`;

  return {
    label: `${cmLabel} (${inLabel})`,
    value: {
      width: printSize.width,
      height: printSize.height,
      optionValueId: printSize.optionValueId,
    },
  };
};

const buildCustomPrintSizes = (
  aspectRatio,
  min,
  maxShortest,
  maxLongest,
  step
) => {
  const values = [];

  let i = min;
  while (true) {
    const width = i;
    const height = i / aspectRatio;

    if (width < min || height < min) {
      i += step;
      continue;
    }

    const shortest = Math.min(width, height);
    const longest = Math.max(width, height);

    if (shortest > maxShortest || longest > maxLongest) {
      break;
    }

    values.push({ width: width, height: height });
    i += step;
  }

  return values;
};

const buildInitialPrintSizeOption = (printSizes, initialPrintSizeId) => {
  let option = printSizes[0];
  if (initialPrintSizeId) {
    option =
      printSizes.find((e) => e.optionValueId === initialPrintSizeId) ||
      printSizes[0];
  }

  return buildPrintSizeOption(option);
};

export default {
  name: "UploadStepCropDigital",
  components: {
    VH3,
    VP,
    VButton,
    Cropper,
    CropLoadingErrorMessage,
    CropDigitalQualitySummary,
    CropDigitalStepLabel,
    CropDigitalPrintSizeSelect,
    CropDigitalPresetPanel,
    CropDigitalDpiError,
  },
  props: {
    uploadUUID: {
      type: String,
      default: undefined,
    },
    isEdit: {
      type: Boolean,
      required: true,
    },
    getPhotoPreviewPath: {
      type: String,
      required: true,
    },
    updateCropDetailsPath: {
      type: String,
      required: true,
    },
    editCropDetailsPath: {
      type: String,
      required: true,
    },
    uploadTypeId: {
      type: String,
      required: true,
    },
    standardPrintSizes: {
      type: Array,
      required: true,
    },
    initialPrintSizeId: {
      type: Number,
      default: undefined,
    },
  },
  data() {
    return {
      printSize: buildInitialPrintSizeOption(
        this.standardPrintSizes,
        this.initialPrintSizeId
      ),
      croppedSize: {
        width: 0,
        height: 0,
        left: 0,
        top: 0,
      },
      activeCropPreset: cropPresets[3],
      customPrintSizes: [],
      photoUrl: undefined,
      isPhotoLoaded: false,
      isPhotoLoadingError: false,
      isSaveInProgress: false,
      isSaveError: false,
      checkStatusTimeout: undefined,
    };
  },
  computed: {
    cropPresets() {
      return cropPresets;
    },
    stencilProps() {
      return {
        aspectRatio: this.cropAspectRatio,
      };
    },
    printSizeOptions() {
      const printSizes = this.isStandardUpload
        ? this.standardPrintSizes
        : this.customPrintSizes;

      return printSizes.map(buildPrintSizeOption);
    },
    cropAspectRatio() {
      if (this.isStandardUpload && this.printSize) {
        return this.printSize.value.width / this.printSize.value.height;
      } else {
        return this.activeCropPreset.aspectRatio;
      }
    },
    isPhotoReady() {
      return this.photoUrl !== undefined && this.isPhotoLoaded;
    },
    isStandardUpload() {
      return this.uploadTypeId === digitalUploadTypes.standard.id;
    },
    isCustomUpload() {
      return this.uploadTypeId === digitalUploadTypes.custom.id;
    },
    isMatchingDpi() {
      return this.calculateDpi(this.croppedSize, this.printSize) >= minDpi;
    },
    isMatchingDpiForSmallestPrintSize() {
      return (
        this.calculateDpi(this.croppedSize, this.printSizeOptions[0]) >= minDpi
      );
    },
  },
  async mounted() {
    const upload = await fetchUpload(this.getPhotoPreviewPath, this.uploadUUID);
    this.photoUrl = upload.originalPhotoUrl;
    this.isPhotoLoaded = false;
  },
  destroyed() {
    if (this.checkStatusTimeout) {
      clearTimeout(this.checkStatusTimeout);
    }
  },
  methods: {
    checkPath() {
      return window.location.search.includes("back_to_product");
    },
    async chooseFrameClicked() {
      if (!this.isPhotoReady || this.isSaveInProgress) {
        return;
      }

      this.isSaveInProgress = true;
      try {
        const path = this.isEdit
          ? this.editCropDetailsPath
          : this.updateCropDetailsPath;
        const result = await saveUploadCrop(
          path,
          this.uploadUUID,
          this.croppedSize,
          this.uploadTypeId,
          this.printSize.value
        );
        const uploadUuid = result.uuid;

        const checkStatusFunction = async () => {
          const result = await fetchUpload(
            this.getPhotoPreviewPath,
            uploadUuid
          );

          if (result.status === "crop_ready") {
            if (this.checkStatusTimeout) {
              this.checkStatusTimeout = undefined;
            }

            this.$emit(
              "uploadCropFinished",
              uploadUuid,
              this.uploadTypeId,
              this.printSize.value
            );
          } else {
            this.checkStatusTimeout = setTimeout(checkStatusFunction, 2000);
          }
        };

        this.checkStatusTimeout = setTimeout(checkStatusFunction, 2000);
      } catch (e) {
        console.error(e);
        this.isSaveError = true;
        this.isSaveInProgress = false;
      }
    },
    changePhotoClicked() {
      this.$emit("changePhotoRequested");
    },
    changeCropPreset(newPreset) {
      this.activeCropPreset = newPreset;
      this.maximizeCropper();
    },
    changeCropping({ coordinates }) {
      const oldCroppedSize = this.croppedSize;

      this.croppedSize = {
        width: coordinates.width,
        height: coordinates.height,
        left: coordinates.left,
        top: coordinates.top,
      };

      if (
        oldCroppedSize.width !== this.croppedSize.width ||
        oldCroppedSize.height !== this.croppedSize.height
      ) {
        this.updateAvailablePrintSizes();
      }
    },
    updateAvailablePrintSizes() {
      if (this.isStandardUpload) {
        return;
      }

      let croppedAspectRatio = this.croppedSize.width / this.croppedSize.height;
      if (isNaN(croppedAspectRatio)) {
        croppedAspectRatio = 1;
      }

      const values = buildCustomPrintSizes(
        croppedAspectRatio,
        minSide,
        maxShortestSide,
        maxLongestSide,
        2
      );

      this.customPrintSizes = values;
      this.printSize = buildPrintSizeOption(values[0]);
    },
    photoLoaded() {
      this.isPhotoLoaded = true;
      this.isPhotoLoadingError = false;
    },
    photoLoadingError() {
      this.isPhotoLoaded = false;
      this.isPhotoLoadingError = true;
    },
    defaultSize({ imageSize, visibleArea }) {
      return {
        width: (visibleArea || imageSize).width,
        height: (visibleArea || imageSize).height,
      };
    },
    maximizeCropper() {
      this.$nextTick(() => {
        this.$refs.cropper.setCoordinates(({ imageSize }) => ({
          width: imageSize.width,
          height: imageSize.height,
        }));
      });
    },
    onPrintSizeSelected() {
      if (this.isStandardUpload) {
        this.maximizeCropper();
      }
    },
    calculateDpi(croppedSize, printSize) {
      const horizontalDpi =
        (croppedSize.width * inchToCm) / parseFloat(printSize.value.width);
      const verticalDpi =
        (croppedSize.height * inchToCm) / parseFloat(printSize.value.height);

      const minDpi = Math.min(horizontalDpi, verticalDpi);
      return Math.floor(minDpi);
    },
  },
};
</script>

<style>
.upload-crop-step .vue-simple-handler {
  @apply bg-yellow;
}

.upload-crop-step .vue-simple-line {
  @apply border-yellow;
}

.upload-crop-step .vue-advanced-cropper__background,
.upload-crop-step .vue-advanced-cropper__foreground {
  @apply bg-white;
}
</style>
