<template>
  <div class="md:grid md:grid-cols-5 gap-2">
    <product-mount-option
      v-for="option in availableMountOptions"
      :key="option.value"
      :label="option.label"
      :icon="option.icon"
      :price="option.price"
      :selected="isSelected(option)"
      class="mb-6"
      @click="$emit('input', option)"
    />
  </div>
</template>

<script>
import ProductMountOption from './ProductMountOption'

export default {
  name: 'ProductMountOptions',
  components: {
    ProductMountOption,
  },
  props: {
    value: {
      type: Object,
      required: true,
    },
    availableMountOptions: {
      type: Array,
      required: true,
    },
  },
  methods: {
    isSelected(option) {
      return this.value.value === option.value
    },
  },
}
</script>
