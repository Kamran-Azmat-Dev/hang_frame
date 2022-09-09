<template>
  <a
    :href="targetUrl"
    class="flex flex-col shadow-md rounded-sm bg-white relative"
    @mouseover="handleMouseOver"
    @mouseleave="handleMouseLeave"
  >
    <product-card-hover-image 
      v-if="hasHoverEffect && hoverImageUrl"
      :hover-image-url="hoverImageUrl"
      :is-visible="isHoverImageVisible"
    />
    <custom-frame-preview
      v-if="isCustom"
      class="h-81 bg-greylight"
      :foil-blocking-options="{ chosen: false }"
      :mount-dimensions="{ left: 6.5, right: 6.5, top: 6.5, bottom: 6.5 }"
      :upload="upload"
      :configuration="customPreviewConfiguration"
      :namespace="`${variant.variantId}`"
    />
    <standard-frame-preview
      v-else-if="variant.framePhotoUrl"
      class="h-81"
      :frame-photo-url="variant.framePhotoUrl"
      :frame-photo-width="variant.framePhotoWidth"
      :frame-photo-height="variant.framePhotoHeight"
      :frame-preview-x="variant.framePreviewX"
      :frame-preview-y="variant.framePreviewY"
      :frame-preview-width="variant.framePreviewWidth"
      :frame-preview-height="variant.framePreviewHeight"
      :upload="upload"
    />
    <div
      v-else
      class="h-81"
    />
    <div class="px-6 pt-5 pb-8 flex-1 flex flex-col">
      <div
        v-if="areColorsAvailable"
        class="flex"
      >
        <color-marker
          v-for="color in availableColors"
          :key="color"
          :color="color"
          class="mr-2"
        />
      </div>
      <div class="flex items-end pt-3 mt-auto mb-0">
        <v-h4>
          {{ name }}
        </v-h4>
        <v-p
          class="ml-auto mr-2"
          :body-size="2"
        >
          {{ formattedPrice }}
        </v-p>
      </div>
      <v-p
        class="mt-4"
        :body-size="3"
      >
        {{ description }}
      </v-p>
    </div>
  </a>
</template>

<script>
import VP from '../Atoms/VP'
import VH4 from '../Atoms/VH4'
import StandardFramePreview from '../Preview/StandardFramePreview'
import CustomFramePreview from '../Preview/CustomFramePreview'
import ColorMarker from './ColorMarker'
import ProductCardHoverImage from './ProductCardHoverImage'

export default {
  name: 'ProductCard',
  components: {
    VP,
    VH4,
    StandardFramePreview,
    CustomFramePreview,
    ColorMarker,
    ProductCardHoverImage
  },
  props: {
    variant: {
      type: Object,
      required: true,
    },
    product: {
      type: Object,
      default: undefined
    },
    mountColor: {
      type: Object,
      default: undefined,
    },
    upload: {
      type: Object,
      default: undefined,
    },
    isCustom: {
      type: Boolean,
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    availableColors: {
      type: Array,
      default() {
        return []
      },
    },
    targetUrl: {
      type: String,
      default: undefined,
    },
    hasHoverEffect: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      isHoverImageVisible: false
    }
  },
  computed: {
    areColorsAvailable() {
      return this.availableColors.length > 0
    },
    formattedPrice() {
      let value

      if (this.isCustom) {
        if (this.upload) {
          const prices = this.upload.mouldingTypePrices
          const priceDetails = prices.find(e => e.mouldingTypeId === this.variant.mouldingTypeId)
          if (priceDetails) {
            value = priceDetails.price
          }
        }
      } else {
        value = parseFloat(this.variant.price)
      }

      if (value) {
        return `\u00a3${value.toFixed(2)}`
      } else {
        return ''
      }
    },
    customPreviewConfiguration() {
      let configuration = {
        ...this.variant.framePreviewConfiguration,
        enableShadows: false,
      }

      if (this.mountColor) {
        configuration = { ...configuration, ...this.mountColor.mountPattern }
      }
      return configuration
    },
    standardUpload() {
      if (this.upload && !this.upload.isCustom) {
        if (this.upload.printSizeId === this.variant.printSizeId) {
          return this.upload
        }
      }

      return undefined
    },
    hoverImage() {
      if (this.product && this.product.images) {
         if (this.isCustom) {
          return this.product.images[0];
        } else {
          return this.product.images[1];
        }
      }

      return undefined;
    },
    hoverImageUrl() {
      if (this.hoverImage) {
        return this.hoverImage.largeUrl;
      }

      return undefined;
    }
  },
  methods: {
    handleMouseOver() {
      if (!this.hasHoverEffect) return;
      this.isHoverImageVisible = true;
    },
    handleMouseLeave() {
      if (!this.hasHoverEffect) return;
      this.isHoverImageVisible = false;
    }
  }
}
</script>
