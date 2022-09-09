<template>
  <v-dropdown
    title="Mount type"
    color="grey"
    :value="value"
    :options="formattedMountTypeOptions"
    @input="newValue => $emit('input', newValue)"
  />
</template>

<script>
import VDropdown from '../Atoms/VDropdown'

export default {
  name: 'ProductMountTypeOptions',
  components: {
    VDropdown,
  },
  props: {
    availableMountTypeOptions: {
      type: Array,
      required: true,
    },
    value: {
      type: Object,
      required: true,
    },
  },
  computed: {
    formattedMountTypeOptions() {
      return this.availableMountTypeOptions.map(e => ({
        ...e,
        label: e.price === 0 ? e.label : `${e.label} (+£${e.price})`,
      }))
    },
  }
}
</script>
