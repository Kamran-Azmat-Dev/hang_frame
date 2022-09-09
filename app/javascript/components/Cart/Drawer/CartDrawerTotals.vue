<template>
  <div>
    <div class="flex">
      <v-p
        class="font-bold"
        :body-size="2"
      >
        Total
      </v-p>
      <v-p
        class="font-bold ml-auto mr-0"
        :body-size="2"
      >
        {{ cartTotal }}
      </v-p>
    </div>
  </div>
</template>

<script>
import VP from '../../Atoms/VP'

export default {
  name: 'CartDrawerTotals',
  components: {
    VP,
  },
  props: {
    cart: {
      type: Object,
      required: true,
    },
  },
  computed: {
    cartTotal() {
      return this.cart.displayTotal
    }
  }
}
</script>
