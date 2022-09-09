<template>
  <v-dropdown
    title="Dimensions"
    :options="printSizeOptions"
    :value="value"
    @input="onInput"
  />
</template>

<script>
import VDropdown from '../../Atoms/VDropdown'

export default {
  name: 'CropDigitalPrintSizeSelect',
  components: {
    VDropdown,
  },
  props: {
    printSizeOptions: {
      type: Array,
      required: true,
    },
    value: {
      type: Object,
      default: undefined,
    },
  },
  methods: {
    onInput(value) {
      this.$emit('input', value)
      this.$emit('selected', value)
    }
  }
}
</script>
