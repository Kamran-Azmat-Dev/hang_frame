<template>
  <img v-if="image.largeUrl" class="w-full" :src="image.largeUrl">
</template>

<script>
export default {
  name: 'FrameImagePreview',
  props: {
    image: {
      type: Object,
      default: undefined,
    },
  },
}
</script>
