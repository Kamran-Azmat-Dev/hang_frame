<template>
  <div>
    <div v-if="cart.promotionTotal" class="flex">
      <v-p :body-size="2" style="color: #1d2019"> Discount </v-p>
      <v-p class="ml-auto mr-0" :body-size="2">
        {{ cartPromotionTotal }}
      </v-p>
    </div>
    <div v-if="cart.treesForLifeItem" class="flex">
      <v-p :body-size="2">
        {{ cartTreesForLifeQuantity }} tree(s) for
        <span class="italic">Trees for Life</span>
      </v-p>
      <v-p class="ml-auto mr-0" :body-size="2">
        &#163;{{ cartTreesForLifeTotal }}
      </v-p>
    </div>
    <div v-if="cart.giftWrapItem" class="flex">
      <p class="mt-4" style="font-size: 18px; font-weight: 400">
        Gift note & wrapping
      </p>
      <v-p class="ml-auto mr-0 mt-4" :body-size="2">
        &#163;{{ cartGiftWrapTotal }}
      </v-p>
    </div>
    <div v-if="cart.pickupItem" class="flex">
      <p class="mt-4" style="font-size: 18px; font-weight: 400">
        Home collection service:
      </p>
      <v-p class="ml-auto mr-0 mt-4" :body-size="2">
        &#163;{{ cartPickupProductTotal }}
      </v-p>
    </div>
    <div class="flex mt-2">
      <v-p
        >Discount coupons will not be applied on <strong>Donations</strong> and
        <strong>Gift Wrap</strong>.</v-p
      >
    </div>
    <div class="flex mt-6">
      <v-p class="font-bold" :body-size="2"> Total </v-p>
      <v-p class="font-bold ml-auto mr-0" :body-size="2">
        {{ cartTotal }}
      </v-p>
    </div>
  </div>
</template>

<script>
import VP from "../../Atoms/VP";

export default {
  name: "CartPageTotals",
  components: {
    VP,
  },
  props: {
    cart: {
      type: Object,
      required: true,
    },
    treesForLifeProduct: {
      type: Object,
      required: true,
    },
    giftWrapProduct: {
      type: Object,
      required: true,
    },
    pickupProduct: {
      type: Object,
      required: true,
    }
  },
  computed: {
    cartTotal() {
      return this.cart.displayTotal;
    },
    cartPromotionTotal() {
      return this.cart.displayPromotionTotal;
    },
    cartTreesForLifeTotal() {
      return parseFloat(
        this.treesForLifeProduct.price * this.cart.treesForLifeItem.quantity
      ).toFixed(2);
    },
    cartGiftWrapTotal() {
      return parseFloat(this.giftWrapProduct.price).toFixed(2);
    },
    cartPickupProductTotal() {
      return parseFloat(this.pickupProduct.price).toFixed(2);
    },
    cartTreesForLifeQuantity() {
      return parseInt(this.cart.treesForLifeItem.quantity);
    },
  },
};
</script>
