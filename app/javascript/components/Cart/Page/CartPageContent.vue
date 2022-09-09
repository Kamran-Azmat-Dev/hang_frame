<template>
  <div>
    <cart-page-item
      v-for="item in cart.lineItems"
      :key="item.id"
      :item="item"
      :cart="cart"
      @edit="$emit('editItem', item)"
      @remove="$emit('removeItem', item)"
      @duplicate="$emit('duplicateItem', item)"
      class="mb-8"
    />

    <cart-page-donate
      v-if="treesForLifeProduct"
      :trees-for-life-product="treesForLifeProduct"
      :cart="cart"
      @addTreesForLife="$emit('addTreesForLife')"
      @removeTreesForLife="$emit('removeTreesForLife')"
      @changeTreesForLifeQuantity="quantity => $emit('changeTreesForLifeQuantity', quantity)"
    />
  </div>
</template>

<script>
import CartPageItem from './CartPageItem'
import CartPageDonate from './CartPageDonate'

export default {
  name: 'CartPageContent',
  components: {
    CartPageItem,
    CartPageDonate,
  },
  props: {
    cart: {
      type: Object,
      required: true,
    },
    treesForLifeProduct: {
      type: Object,
      default: undefined,
    },
    giftWrapProduct: {
      type: Object,
      default: undefined
    },
    pickupProduct: {
      type: Object,
      default: undefined
    },
  },
}
</script>
