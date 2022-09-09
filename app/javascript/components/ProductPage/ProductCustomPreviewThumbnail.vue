<template>
  <custom-frame-preview
    class="w-27 h-27 cursor-pointer"
    :class="classes"
    :configuration="framePreviewConfiguration"
    :foil-blocking-options="foilBlockingOptions"
    :mount-dimensions="mountDimensionsWithDefaults"
    :upload="upload"
  />
</template>

<script>
import CustomFramePreview from '../Preview/CustomFramePreview'

export default {
  name: 'ProductCustomPreviewThumbnail',
  components: {
    CustomFramePreview,
  },
  props: {
    product: {
      type: Object,
      required: true,
    },
    mountColor: {
      type: Object,
      required: true,
    },
    isSelected: {
      type: Boolean,
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
  },
  computed: {
    classes() {
      if (this.isSelected) {
        return ['border-2', 'border-grey']
      }

      return ['border', 'border-grey20']
    },
    framePreviewConfiguration() {
      return {
        ...this.product.variant.framePreviewConfiguration,
        ...this.mountColor.mountPattern,
      }
    },
    foilBlockingOptions() {
      return {
        chosen: false,
      }
    },
    mountDimensionsWithDefaults() {
      if (this.mountDimensions) {
        return this.mountDimensions
      } else {
        return {
          top: 6,
          left: 6,
          bottom: 6,
          right: 6,
        }
      }
    },
  },
}
</script>
