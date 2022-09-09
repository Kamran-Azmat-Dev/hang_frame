<template>
  <div class="flex flex-col items-center">
    <div v-if="isMismatchedUploadPrintSize" class="text-lg mb-4 text-center">
      This frame requires a digital photo sized {{ productPrintSize }}cm
    </div>
    <v-button
      class="w-full max-w-77 flex"
      @click="changeCropping"
      v-if="upload"
    >
      <div class="flex items-center mx-auto">Change cropping</div>
    </v-button>
    <v-button class="w-full max-w-77 flex" @click="startFraming" v-else>
      <div class="flex items-center mx-auto">Upload</div>
    </v-button>
  </div>
</template>

<script>
import VButton from "../Atoms/VButton";

export default {
  name: "ProductCartUnavailableButton",
  components: {
    VButton,
  },
  props: {
    routes: {
      type: Object,
      required: true,
    },
    product: {
      type: Object,
      required: true,
    },
    isMismatchedUploadPrintSize: {
      type: Boolean,
      default: false,
    },
    productPrintSize: {
      type: String,
      default: undefined,
    },
    upload: {
      type: Object,
      default: undefined,
    },
  },
  methods: {
    startFraming() {
      if (this.product.isCustom) {
        window.location = `${this.routes.digitalUploadPath}`;
      } else {
        window.location = `${this.routes.digitalUploadPath}?back_to_product=${this.product.slug}&upload_type=standard&print_size_id=${this.product.variant.printSizeId}`;
      }
    },
    changeCropping() {
      window.location = `${this.routes.digitalUploadPath}?back_to_product=${this.product.slug}&upload_type=standard&print_size_id=${this.product.variant.printSizeId}&edit_upload_uuid=${this.upload.uuid}`;
    },
  },
};
</script>
