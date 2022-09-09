<template>
  <standard-frame-preview
    class="w-27 h-27 cursor-pointer"
    :class="classes"
    :frame-photo-url="variant.framePhotoUrl"
    :frame-photo-width="variant.framePhotoWidth"
    :frame-photo-height="variant.framePhotoHeight"
    :frame-preview-x="variant.framePreviewX"
    :frame-preview-y="variant.framePreviewY"
    :frame-preview-width="variant.framePreviewWidth"
    :frame-preview-height="variant.framePreviewHeight"
    :upload="upload"
  />
</template>

<script>
import StandardFramePreview from '../Preview/StandardFramePreview'

export default {
  name: 'ProductStandardPreviewThumbnail',
  components: {
    StandardFramePreview,
  },
  props: {
    variant: {
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
  },
  computed: {
    classes() {
      if (this.isSelected) {
        return ['border-2', 'border-grey']
      }

      return ['border', 'border-grey20']
    },
  },
}
</script>
