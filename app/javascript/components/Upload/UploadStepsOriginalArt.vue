<template>
  <div class="bg-neutral w-full flex flex-col items-center">
    <div class="w-full max-w-screen-xl pt-19 md:pt-32 pb-18 md:pb-36 px-6">
      <upload-step-file
        v-if="step === steps.file"
        :routes="routes"
        :is-digital="false"
        :upload-photo-path="routes.uploadPhotoPath"
        @uploadPhotoFinished="uploadPhotoFinished"
      />
      <upload-step-crop-original-art
        v-if="step === steps.crop"
        :uploadUUID="uploadUUID"
        :get-photo-preview-path="routes.getPhotoPreviewPath"
        :update-crop-details-path="routes.updateCropDetailsPath"
        :original-art-types="originalArtTypes"
        @uploadCropFinished="uploadCropFinished"
        @changePhotoRequested="changePhotoRequested"
      />
    </div>
  </div>
</template>

<script>
import axios from "axios";
import UploadStepFile from "./File/UploadStepFile";
import UploadStepCropOriginalArt from "./CropOriginalArt/UploadStepCropOriginalArt";
import { buildCartHeaders, fetchCart } from "../../lib/api/cart";

const steps = {
  file: 1,
  crop: 2,
};

export default {
  name: "UploadStepsOriginalArt",
  components: {
    UploadStepFile,
    UploadStepCropOriginalArt,
  },
  props: {
    routes: {
      type: Object,
      required: true,
    },
    originalArtTypes: {
      type: Array,
      required: true,
    },
    cloneLineItemId: {
      type: Number,
      default: undefined,
    },
  },
  data() {
    return {
      step: steps.file,
      uploadUUID: undefined,
    };
  },
  computed: {
    steps() {
      return steps;
    },
  },
  methods: {
    uploadPhotoFinished(uploadUUID) {
      this.uploadUUID = uploadUUID;
      this.changeStep(steps.crop);
    },
    changePhotoRequested() {
      this.changeStep(steps.file);
    },
    uploadCropFinished() {
      const cookieExpiry = 60 * 60 * 24 * 10; // 10 days
      this.$cookies.set("uploadUUID", this.uploadUUID, cookieExpiry);

      if (this.cloneLineItemId) {
        this.redirectToClonedProduct();
      } else {
        this.redirectToFrameChoice();
      }
    },
    changeStep(newStep) {
      this.step = newStep;
      window.scrollTo(0, 0);
    },
    redirectToFrameChoice() {
      window.location = this.routes.customFramesPath;
    },
    async redirectToClonedProduct() {
      const cartTokenResponse = await axios.post(
        this.routes.ensureCartPath,
        {},
        { withCredentials: true }
      );
      const cartToken = cartTokenResponse.data.token;

      const headers = {
        ...buildCartHeaders(),
        "X-Spree-Order-Token": cartToken,
      };
      const cart = await fetchCart(headers, this.routes.getCartPath);

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
  },
};
</script>
