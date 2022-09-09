<template>
  <button
    class="tracking-wide text-sm leading-lg font-bold uppercase focus:outline-none"
    :class="classes"
    :disabled="disabled"
    @click="$emit('click')"
  >
    <slot />
  </button>
</template>

<script>
export default {
  name: 'VButton',
  props: {
    styleVariant: {
      type: String,
      default: 'primary',
    },
    paddingClasses: {
      type: Array,
      default() {
        return ['py-4']
      },
    },
    disabled: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    classes() {
      return [
        ...this.backgroundClasses,
        ...this.borderClasses,
        ...this.paddingClasses
      ]
    },
    backgroundClasses() {
      if (this.disabled) return ['bg-cement', 'border-cement', 'text-grey'];

      switch (this.styleVariant) {
        case 'primary':
          return ['bg-yellow', 'border-yellow', 'hover:bg-yellow2', 'hover:border-yellow2', 'text-grey'];
        case 'secondary':
          return ['bg-grey', 'border-grey', 'hover:bg-transparent', 'text-white', 'hover:text-grey'];
        case 'ghost':
          return ['hover:underline', 'text-grey'];
        case 'outline':
          return ['bg-transparent', 'hover:bg-yellow', 'hover:text-grey', 'hover:border-yellow']
        default:
          return []
      }
    },
    borderClasses() {
      if (this.styleVariant === 'ghost') {
        return []
      } else {
        return ['border-2', 'rounded-lg']
      }
    }
  }
}
</script>
