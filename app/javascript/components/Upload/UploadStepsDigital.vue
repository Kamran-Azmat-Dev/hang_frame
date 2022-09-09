<template>
  <div class="bg-neutral w-full flex flex-col items-center">
    <div class="w-full max-w-screen-xl pt-19 md:pt-32 pb-18 md:pb-36 px-6">
      <upload-step-type
        v-if="step === steps.type"
        @uploadTypeSelected="uploadTypeSelected"
      />
      <upload-step-file
        v-if="step === steps.file"
        :routes="routes"
        :is-digital="true"
        :upload-photo-path="routes.uploadPhotoPath"
        @uploadPhotoFinished="uploadPhotoFinished"
      />
      <upload-step-crop-digital
        v-if="step === steps.crop"
        :uploadUUID="uploadUUID"
        :is-edit="editUploadUuid !== undefined"
        :get-photo-preview-path="routes.getPhotoPreviewPath"
        :update-crop-details-path="routes.updateCropDetailsPath"
        :edit-crop-details-path="routes.editCropDetailsPath"
        :upload-type-id="uploadTypeId"
        :standard-print-sizes="standardPrintSizes"
        :initial-print-size-id="initialPrintSizeId"
        @uploadCropFinished="uploadCropFinished"
        @changePhotoRequested="changePhotoRequested"
      />
    </div>
  </div>
</template>

<script>
import UploadStepType from "./Type/UploadStepType";
import UploadStepFile from "./File/UploadStepFile";
import UploadStepCropDigital from "./CropDigital/UploadStepCropDigital";
import { digitalUploadTypes } from "./constants";
import { fetchCart } from "../../lib/api/cart";

const steps = {
  type: 1,
  file: 2,
  crop: 3,
};

const initialStep = (initialUploadType, cloneLineItemId, editUploadUuid) => {
  if (editUploadUuid) {
    return steps.crop;
  }
  if (cloneLineItemId || initialUploadType) {
    return steps.file;
  } else {
    return steps.type;
  }
};

const generateInitialUploadType = (initialUploadType, cloneLineItemId) => {
  if (initialUploadType) {
    return initialUploadType === "standard"
      ? digitalUploadTypes.standard.id
      : digitalUploadTypes.custom.id;
  }
  return cloneLineItemId
    ? digitalUploadTypes.custom.id
    : digitalUploadTypes.standard.id;
};

export default {
  name: "UploadStepsDigital",
  components: {
    UploadStepType,
    UploadStepFile,
    UploadStepCropDigital,
  },
  props: {
    routes: {
      type: Object,
      required: true,
    },
    standardPrintSizes: {
      type: Array,
      required: true,
    },
    cloneLineItemId: {
      type: Number,
      default: undefined,
    },
    editUploadUuid: {
      type: String,
      default: undefined,
    },
    backToProduct: {
      type: String,
      default: undefined,
    },
    initialUploadType: {
      type: String,
      default: undefined,
    },
    initialPrintSizeId: {
      type: Number,
      default: undefined,
    },
  },
  data() {
    return {
      step: initialStep(
        this.initialUploadType,
        this.cloneLineItemId,
        this.editUploadUuid
      ),
      uploadUUID: this.editUploadUuid,
      uploadTypeId: generateInitialUploadType(
        this.initialUploadType,
        this.cloneLineItemId
      ),
    };
  },
  computed: {
    steps() {
      return steps;
    },
  },
  methods: {
    uploadTypeSelected(typeId) {
      if (typeId == "standard") {
        window.location = this.routes.originalArtUploadPath;
      } else {
        this.uploadTypeId = typeId;
        this.changeStep(steps.file);
      }
    },
    uploadPhotoFinished(uploadUUID) {
      this.uploadUUID = uploadUUID;
      this.changeStep(steps.crop);
    },
    changePhotoRequested() {
      if (this.cloneLineItemId) {
        this.changeStep(steps.file);
      } else {
        this.changeStep(steps.file);
      }
    },
    uploadCropFinished(uploadUuid, uploadTypeId, printSize) {
      const cookieExpiry = 60 * 60 * 24 * 10; // 10 days
      this.$cookies.set("uploadUUID", uploadUuid, cookieExpiry);

      if (this.cloneLineItemId) {
        this.redirectToClonedProduct();
      } else if (this.backToProduct) {
        this.redirectToProduct();
      } else {
        this.redirectToFrameChoice(uploadTypeId, printSize);
      }
    },
    async redirectToClonedProduct() {
      const cart = await fetchCart(this.routes);

      const lineItem = cart.lineItems.find(
        (e) => e.id === this.cloneLineItemId
      );

      if (!lineItem) {
        this.redirectToFrameChoice();
      }

      const location = [
        this.routes.productPath.replace(":id", lineItem.productSlug),
        "?clone_line_item_id=",
        this.cloneLineItemId,
      ].join("");

      window.location = location;
    },
    redirectToProduct() {
      window.location = this.routes.productPath.replace(
        ":id",
        this.backToProduct
      );
    },
    redirectToFrameChoice(uploadTypeId, printSize) {
      if (uploadTypeId === digitalUploadTypes.standard.id) {
        window.location = `${this.routes.standardFramesPath}?printsize=${printSize.optionValueId}`;
      } else {
        window.location = this.routes.customFramesPath;
      }
    },
    changeStep(newStep) {
      this.step = newStep;
      window.scrollTo(0, 0);
    },
  },
};
</script>
