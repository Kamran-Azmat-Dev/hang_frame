<template>
  <div>
    <v-small-heading class="text-grey2"> Art dimensions </v-small-heading>
    <div class="flex items-center">
      <v-p :body-size="1"> {{ formattedWidth }} x {{ formattedHeight }}cm </v-p>
      <a
        v-if="isDigital && product.isCustom"
        :href="changeArtDimensionsPath"
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
import { formatFrameDimension } from "../../display";

export default {
  name: "ProductSectionArtDimensions",
  components: {
    VSmallHeading,
    VP,
  },
  props: {
    upload: {
      type: Object,
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
  },
  computed: {
    formattedWidth() {
      return formatFrameDimension(this.upload.printWidth);
    },
    formattedHeight() {
      return formatFrameDimension(this.upload.printHeight);
    },
    isDigital() {
      return this.upload.uploadType !== "original";
    },
    changeArtDimensionsPath() {
      if(this.product.isCustom) {
        return `${this.routes.changeArtDimensionsPath}?back_to_product=${this.product.slug}&upload_type=custom&print_size_id=${this.product.variant.printSizeId}&edit_upload_uuid=${this.upload.uuid}`;
      } else {
        return `${this.routes.changeArtDimensionsPath}?back_to_product=${this.product.slug}&upload_type=standard&print_size_id=${this.product.variant.printSizeId}&edit_upload_uuid=${this.upload.uuid}`;
      }
    },
  },
};
</script>
