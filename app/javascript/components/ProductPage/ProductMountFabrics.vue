<template>
  <div class="md:grid md:grid-cols-5 gap-2">
    <product-mount-fabric
      label="Classic"
      color="#fff"
      :selected="!value"
      class="mt-6"
      @click="$emit('input', false)"
    />
    <product-mount-fabric
      label="Linen"
      color="#F5F5F4"
      :selected="value"
      :price="linenAdditional.price"
      class="mt-6"
      @click="$emit('input', true)"
    />
  </div>
</template>

<script>
import ProductMountFabric from './ProductMountFabric'

export default {
  name: 'ProductMountFabrics',
  components: {
    ProductMountFabric,
  },
  props: {
    value: {
      type: Boolean,
      required: true,
    },
    linenAdditional: {
      type: Object,
      required: true,
    },
  },
}
</script>
