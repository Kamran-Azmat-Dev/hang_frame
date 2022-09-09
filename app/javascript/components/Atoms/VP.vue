<template>
  <p :class="classes">
    <slot />
  </p>
</template>

<script>
export default {
  name: 'VP',
  props: {
    bodySize: {
      type: Number,
      required: true,
    },
  },
  computed: {
    classes() {
      if (this.bodySize === 1) {
        return ['text-base-plus', 'leading-base-plus', 'md:text-xl', 'md:leading-xl']
      } else if (this.bodySize === 2) {
        return ['md:text-lg', 'md:leading-lg']
      } else {
        return ['md:leading-xs']
      }
    }
  }
}
</script>
