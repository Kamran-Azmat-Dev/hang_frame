<template>
  <div class="w-25 h-40">
    <div
      class="w-25 h-40 bg-contain bg-center bg-no-repeat cursor-pointer transition-all duration-200 ease-in"
      :class="previewClasses"
      :style="previewStyles"
    />
  </div>
</template>

<script>
export default {
  name: 'ChevronPreview',
  props: {
    imageUrl: {
      type: String,
      required: true,
    },
    isSelected: {
      type: Boolean,
      required: true,
    },
  },
  computed: {
    previewStyles() {
      return {
        backgroundImage: `url(${this.imageUrl})`,
        filter: 'drop-shadow(2px 2px 3px rgba(0, 0, 0, 0.2))',
      }
    },
    previewClasses() {
      if (this.isSelected) {
        return ['transform', 'scale-125']
      }

      return []
    }
  }
}
</script>
