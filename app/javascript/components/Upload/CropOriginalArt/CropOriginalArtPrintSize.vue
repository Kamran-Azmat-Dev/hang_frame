<template>
  <div class="grid grid-cols-2 gap-4">
    <v-input-print-size
      :value="widthString"
      color="grey"
      title="Width"
      @blur="value => onWidthChanged(value)"
    />
    <v-input-print-size
      :value="heightString"
      color="grey"
      title="Height"
      @blur="value => onHeightChanged(value)"
    />
  </div>
</template>

<script>
import VInputPrintSize from '../../Atoms/VInputPrintSize.vue'

const numericValue = (value) => {
  return parseFloat(value) || 0
}

export default {
  name: 'CropOriginalArtPrintSize',
  components: {
    VInputPrintSize,
  },
  props: {
    value: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      width: this.value.width.toFixed(1),
      height: this.value.height.toFixed(1),
    }
  },
  computed: {
    widthString() {
      return this.value.width.toString()
    },
    heightString() {
      return this.value.height.toString()
    },
  },
  methods: {
    onWidthChanged(newValue) {
      const valueToEmit = Math.max(numericValue(2), numericValue(newValue))
      this.$emit('input', {
        width: valueToEmit,
        height: numericValue(this.value.height)
      })
    },
    onHeightChanged(newValue) {
      const valueToEmit = Math.max(numericValue(2), numericValue(newValue))
      this.$emit('input', {
        width: numericValue(this.value.width),
        height: valueToEmit
      })
    },
  },
}
</script>
