<template>
  <v-dropdown
    title="Art Type"
    :options="originalArtTypeOptions"
    :value="value"
    @input="newValue => $emit('input', newValue)"
  />
</template>

<script>
import VDropdown from '../../Atoms/VDropdown'

export default {
  name: 'CropOriginalArtTypeSelect',
  components: {
    VDropdown,
  },
  props: {
    originalArtTypeOptions: {
      type: Array,
      required: true,
    },
    value: {
      type: Object,
      default: undefined,
    },
  }
}
</script>
