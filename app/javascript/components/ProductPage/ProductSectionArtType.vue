<template>
  <div class="art-type">
    <v-small-heading class="text-grey2"> Art type </v-small-heading>
    <div class="flex items-center">
      <v-p :body-size="1">
        {{ artType }}
      </v-p>
      <a
        v-if="(upload && product.isPersonalizedStandard) || !product.isCustom"
        @click="changeCropping"
        style="cursor: pointer; margin-left: 200px"
        class="
          font-bold
          uppercase
          text-grey2 text-xs
          leading-xs
          hover:underline
        "
      >
        Crop
      </a>
      <a
        href="/upload/digital"
        style="cursor: pointer"
        class="
          font-bold
          uppercase
          text-grey2 text-xs
          leading-xs
          hover:underline
          ml-auto
        "
      >
        Change
      </a>
    </div>
  </div>
</template>

<script>
import VSmallHeading from "../Atoms/VSmallHeading";
import VP from "../Atoms/VP";
import VButton from "../Atoms/VButton.vue";

export default {
  name: "ProductSectionArtType",
  components: {
    VSmallHeading,
    VP,
    VButton,
  },
  props: {
    upload: {
      type: Object,
      required: true,
    },
    changePhotoPath: {
      type: String,
      required: true,
    },
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
  },
  computed: {
    artType() {
      if (this.upload.uploadType === "original") {
        return "Original art";
      } else {
        return "Digital photo";
      }
    },
    isDigital() {
      return this.upload.uploadType !== "original";
    },
  },
  methods: {
    changeCropping() {
      window.location = `${this.routes.digitalUploadPath}?back_to_product=${this.product.slug}&upload_type=standard&print_size_id=${this.product.variant.printSizeId}&edit_upload_uuid=${this.upload.uuid}`;
    },

    // startFraming() {
    //   if (this.product.isCustom) {
    //     if (this.artType === "Digital photo") {
    //       window.location = `${this.routes.digitalUploadPath}?back_to_product=${this.product.slug}&upload_type=custom&print_size_id=${this.product.variant.printSizeId}`;
    //     } else {
    //       window.location = `${this.routes.originalArtUploadPath}?back_to_product=${this.product.slug}?upload_type=custom`;
    //     }
    //   } else {
    //     window.location = `${this.routes.digitalUploadPath}?back_to_product=${this.product.slug}&upload_type=standard&print_size_id=${this.product.variant.printSizeId}`;
    //   }
    // },
  },
};
</script>

<style>
.art-type p {
  flex-grow: 1;
}

.art-type a:last-child {
  margin-left: 30px;
}
</style>
