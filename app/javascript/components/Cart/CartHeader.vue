<template>
  <div class="flex">
    <img
      src="~images/close-cart-drawer.svg"
      class="w-10 h-10 flex-shrink-0 cursor-pointer"
      @click="$emit('hideCartDrawer')"
    />
    <v-h4 class="text-center flex-1">{{ header }}</v-h4>
    <div class="w-10 h-10 flex-shrink-0" />
  </div>
</template>

<script>
import VH4 from '../Atoms/VH4'

export default {
  name: 'CartHeader',
  components: {
    VH4,
  },
  props: {
    cart: {
      type: Object,
      default: undefined,
    }
  },
  computed: {
    header() {
      if (!this.cart) {
        return 'Basket'
      }

      const itemCount = this.cart.framesItemsCount
      if (itemCount === 0) {
        return 'Basket'
      }

      return `Basket (${itemCount})`
    }
  }
}
</script>
