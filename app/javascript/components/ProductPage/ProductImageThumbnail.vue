<template>
  <div
    class="bg-cover bg-center bg-no-repeat w-27 h-27 cursor-pointer"
    :class="classes"
    :style="styles"
  />
</template>

<script>
export default {
  name: 'ProductImageThumbnail',
  props: {
    image: {
      type: Object,
      required: true,
    },
    isSelected: {
      type: Boolean,
      required: true,
    },
  },
  computed: {
    styles() {
      return {
        backgroundImage: `url(${this.image.thumbnailUrl})`,
      }
    },
    classes() {
      if (this.isSelected) {
        return ['border-2', 'border-grey']
      }

      return ['border', 'border-grey20']
    }
  },
}
</script>
