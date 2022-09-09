<template>
  <div class="flex flex-col h-full">
    <div class="overflow-scroll pt-19">
      <cart-drawer-item
        v-for="item in cart.lineItems"
        :key="item.id"
        :item="item"
        @remove="$emit('removeItem', item)"
        @duplicate="$emit('duplicateItem', item)"
        class="mb-8 mr-8"
      />
    </div>
    <v-hr />
    <cart-drawer-totals :cart="cart" class="mt-6" />
    <v-button class="mt-8 w-full" @click="checkout"> View Basket</v-button>
  </div>
</template>

<script>
import VButton from "../../Atoms/VButton";
import VHr from "../../Atoms/VHr";
import CartDrawerItem from "./CartDrawerItem";
import CartDrawerTotals from "./CartDrawerTotals";

export default {
  name: "CartDrawerContent",
  components: {
    VButton,
    VHr,
    CartDrawerItem,
    CartDrawerTotals,
  },
  props: {
    cart: {
      type: Object,
      required: true,
    },
    cartPath: {
      type: String,
      required: true,
    },
  },
  methods: {
    checkout() {
      window.location = this.cartPath;
    },
  },
};
</script>
