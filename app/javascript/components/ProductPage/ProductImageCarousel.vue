<template>
  <flicking
    :options="flickingOptions"
    :tag="'div'"
    :viewport-tag="'div'"
    :camera-tag="'div'"
    ref="flicking"
    @select="(e) => imageSelected(e)"
  >
    <product-custom-preview-thumbnail
      v-if="!firstImage && (product.isCustom || product.isPersonalizedStandard)"
      :product="product"
      :mount-color="mountColor"
      :mount-dimensions="mountDimensions"
      :upload="upload"
      :is-selected="currentImage === undefined"
    />
    <product-standard-preview-thumbnail
      v-if="
        firstImage && (!product.isCustom || !product.isPersonalizedStandard)
      "
      :is-selected="isSelected(firstImage)"
      :variant="variant"
      :upload="upload"
    />
    <product-image-thumbnail
      v-for="image in remainingImages"
      :key="image.id"
      :is-selected="isSelected(image)"
      :image="image"
    />
  </flicking>
</template>

<script>
import ProductImageThumbnail from "./ProductImageThumbnail";
import ProductStandardPreviewThumbnail from "./ProductStandardPreviewThumbnail";
import ProductCustomPreviewThumbnail from "./ProductCustomPreviewThumbnail";

export default {
  name: "ProductImageCarousel",
  components: {
    ProductImageThumbnail,
    ProductStandardPreviewThumbnail,
    ProductCustomPreviewThumbnail,
  },
  props: {
    product: {
      type: Object,
      required: true,
    },
    variant: {
      type: Object,
      required: true,
    },
    upload: {
      type: Object,
      default: undefined,
    },
    mountDimensions: {
      type: Object,
      default: undefined,
    },
    mountColor: {
      type: Object,
      default: undefined,
    },
    currentImage: {
      type: Object,
      default: undefined,
    },
  },
  computed: {
    flickingOptions() {
      return {
        circular: false,
        collectStatistics: false,
        autoResize: true,
        bound: true,
        zIndex: 20,
        gap: 24,
      };
    },
    firstImage() {
      if (this.product.isCustom) {
        return undefined;
      } else {
        if (this.product.isPersonalizedStandard) {
          return undefined;
        } else {
          return this.product.images[0];
        }
      }
    },
    remainingImages() {
      if (this.product.isCustom) {
        return this.product.images;
      }
      return this.product.images.slice(1);
    },
  },
  methods: {
    isSelected(image) {
      if (!this.currentImage) {
        return false;
      }

      return this.currentImage.id === image.id;
    },
    imageSelected(e) {
      let selectedIndex = 0;
      if (this.product.isCustom) {
        selectedIndex = e.index - 1;
      } else {
        if (this.product.isPersonalizedStandard) {
          if (e.index !== 0) {
            selectedIndex = e.index;
          } else {
            selectedIndex = e.index - 1;
          }
        } else {
          selectedIndex = e.index;
        }
      }
      const image = this.product.images[selectedIndex];
      this.$emit("change", image);
    },
  },
};
</script>
