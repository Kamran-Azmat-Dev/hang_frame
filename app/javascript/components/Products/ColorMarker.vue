<template>
  <div
    class="rounded-full flex items-center"
    :class="borderClasses"
    @click="$emit('click')"
  >
    <div
      class="shadow-sm2 rounded-full m-auto"
      :class="classes"
      :style="styles"
    />
  </div>
</template>

<script>
export default {
  name: 'ColorMarker',
  props: {
    color: {
      type: String,
      required: true,
    },
    selected: {
      type: Boolean,
      default: false,
    },
    selectable: {
      type: Boolean,
      default: false,
    },
    size: {
      type: Number,
      default: 3,
    }
  },
  computed: {
    borderClasses() {
      const classes = []
      if (this.selected) {
        classes.push('border', 'border-gray')
      }

      if (this.selectable) {
        classes.push('cursor-pointer')
      }

      if (this.size === 1) {
        classes.push('w-14', 'h-14')
      } else if (this.size === 2) {
        classes.push('w-10', 'h-10')
      } else {
        classes.push('w-7', 'h-7')
      }

      return classes
    },
    classes() {
      if (this.size === 1) {
        return ['w-11', 'h-11']
      } else if (this.size === 2) {
        return ['w-8', 'h-8']
      } else {
        return ['w-6', 'h-6']
      }
    },
    styles() {
      return {
        backgroundColor: this.color,
      }
    },
  },
}
</script>
