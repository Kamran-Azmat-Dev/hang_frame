<template>
  <div class="w-full flex flex-col items-center upload-crop-step">
    <v-h3 class="text-center">
      What is the size of your
      <span class="italic">art?</span>
    </v-h3>
    <span
      v-if="!isDigital"
      class="my-1 w-full flex flex-col text-center"
      style="font-size: 16px"
    >
      Select the type of art you are framing then Input the width and height.
      Crop
      <br />the preview image to the border of the art.
    </span>
    <div class="w-full mt-12 grid md:grid-cols-12 md:gap-6">
      <div class="md:col-start-5 md:col-span-4 flex flex-col items-center">
        <crop-original-art-type-select
          class="w-full max-w-90"
          :original-art-type-options="originalArtTypeOptions"
          v-model="originalArtType"
        />
      </div>

      <div class="md:col-start-5 md:col-span-4 flex flex-col items-center">
        <div
          class="
            tracking-wide
            text-sm
            leading-base
            text-grey2
            uppercase
            font-bold
            w-full
            max-w-90
            px-6
            pt-7
          "
        >
          Art Dimensions (cm)
        </div>
        <crop-original-art-print-size
          class="w-full max-w-90 mt-4"
          v-model="printSize"
        />
        <v-p
          v-if="!isMinimumSizeMet"
          :body-size="3"
          class="text-red text-center mt-4"
        >
          The minimum available size is {{ minSide }}x{{ minSide }}cm.
        </v-p>
        <v-p
          v-if="!isMaximumSizeMet"
          :body-size="3"
          class="text-red text-center mt-4"
        >
          The maximum available size is {{ maxShortestSide }}x{{
            maxLongestSide
          }}cm.
        </v-p>
      </div>
      <div class="md:col-start-9 md:col-span-4 flex items-end">
        <v-p
          class="text-grey50 mt-4 w-full text-center md:mt-0 md:text-left"
          :body-size="2"
        >
          Note: We will measure your artwork on receipt.
          <br />
          These will help us calculate your frame quote.
        </v-p>
      </div>
    </div>
    <crop-loading-error-message v-if="isPhotoLoadingError" />
    <div class="w-full mt-16 grid md:grid-cols-12 md:gap-6">
      <div class="md:col-start-5 md:col-span-4 flex flex-col items-center">
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
            :src="photoUrl"
            :stencil-props="stencilProps"
            :resize-image="false"
            :check-orientation="false"
            :default-size="defaultSize"
            @change="changeCropping"
            @ready="photoLoaded"
            @error="photoLoadingError"
          />
        </div>
      </div>
    </div>
    <div class="w-full mt-16 grid md:grid-cols-12 md:gap-6">
      <div class="md:col-start-5 md:col-span-4">
        <v-checkbox
          name="original-art-confirmation"
          class="flex items-center"
          v-model="isOriginalArtConfirmed"
        >
          <v-p :body-size="3">
            Please confirm this is a preview of your art, and NOT a digital
            image you wish to be printed
          </v-p>
        </v-checkbox>
      </div>
    </div>
    <v-button
      class="w-full max-w-77 mt-16 flex flex-col items-center"
      :disabled="
        !isPhotoReady ||
        isSaveInProgress ||
        !isOriginalArtConfirmed ||
        !isMinimumSizeMet ||
        !isMaximumSizeMet
      "
      @click="chooseFrameClicked"
    >
      <div v-if="isSaveInProgress" class="flex mx-auto items-center">
        <img src="~images/loading.gif" class="w-4 h-4 mr-4" />
        Cropping...
      </div>
      <span v-else-if="isSaveError">Failed to save</span>
      <!-- <span v-else-if="originalArtTypeOptions">Back to frame</span> -->
      <span v-else>Choose a Frame</span>
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
import VCheckbox from "../../Atoms/VCheckbox";
import CropLoadingErrorMessage from "../Crop/CropLoadingErrorMessage";
import CropOriginalArtTypeSelect from "./CropOriginalArtTypeSelect";
import CropOriginalArtPrintSize from "./CropOriginalArtPrintSize";
import {
  originalUploadTypeId,
  originalArtMinSide,
  maxLongestSide,
  maxShortestSide,
} from "../constants";
import { fetchUpload, saveUploadCrop } from "../../../lib/api/upload";
import "vue-advanced-cropper/dist/style.css";

const buildOriginalArtTypeOption = (originalArtType) => ({
  label: originalArtType ? originalArtType.name : "default",
  value: originalArtType ? originalArtType.id : "1",
});

export default {
  name: "UploadStepCropOriginalArt",
  components: {
    VH3,
    VP,
    VButton,
    VCheckbox,
    Cropper,
    CropLoadingErrorMessage,
    CropOriginalArtTypeSelect,
    CropOriginalArtPrintSize,
  },
  props: {
    uploadUUID: {
      type: String,
      default: undefined,
    },
    getPhotoPreviewPath: {
      type: String,
      required: true,
    },
    updateCropDetailsPath: {
      type: String,
      required: true,
    },
    originalArtTypes: {
      type: Array,
      required: true,
    },
    title: {
      type: String,
      default: undefined,
    },
  },
  data() {
    return {
      croppedSize: {
        width: 0,
        height: 0,
        left: 0,
        top: 0,
      },
      printSize: {
        width: 10,
        height: 10,
      },
      originalArtType: buildOriginalArtTypeOption(this.originalArtTypes[0]),
      photoUrl: undefined,
      isPhotoLoaded: false,
      isPhotoLoadingError: false,
      isSaveInProgress: false,
      isSaveError: false,
      isOriginalArtConfirmed: false,
      checkStatusTimeout: undefined,
    };
  },
  computed: {
    stencilProps() {
      return {
        aspectRatio: this.cropAspectRatio,
      };
    },
    originalArtTypeOptions() {
      return this.originalArtTypes.map(buildOriginalArtTypeOption);
    },
    cropAspectRatio() {
      return this.printSize.width / this.printSize.height;
    },
    isPhotoReady() {
      return this.photoUrl !== undefined && this.isPhotoLoaded;
    },
    isMinimumSizeMet() {
      return (
        this.printSize.width >= originalArtMinSide &&
        this.printSize.height >= originalArtMinSide
      );
    },
    isMaximumSizeMet() {
      const shortest = Math.min(this.printSize.width, this.printSize.height);
      const longest = Math.max(this.printSize.width, this.printSize.height);

      return shortest <= maxShortestSide && longest <= maxLongestSide;
    },
    minSide() {
      return originalArtMinSide;
    },
    maxLongestSide() {
      return maxLongestSide;
    },
    maxShortestSide() {
      return maxShortestSide;
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
    async chooseFrameClicked() {
      if (
        !this.isPhotoReady ||
        this.isSaveInProgress ||
        !this.isOriginalArtConfirmed
      ) {
        return;
      }
      this.isSaveInProgress = true;
      try {
        const result = await saveUploadCrop(
          this.updateCropDetailsPath,
          this.uploadUUID,
          this.croppedSize,
          originalUploadTypeId,
          this.printSize
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

            this.$emit("uploadCropFinished");
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
    changeCropping({ coordinates }) {
      this.croppedSize = {
        width: coordinates.width,
        height: coordinates.height,
        left: coordinates.left,
        top: coordinates.top,
      };
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
