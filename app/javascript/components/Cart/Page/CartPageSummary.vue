<template>
  <div>
    <cart-page-totals
      :cart="cart"
      :trees-for-life-product="treesForLifeProduct"
      :gift-wrap-product="giftWrapProduct"
      :pickup-product="pickupProduct"
    />
    <cart-page-discount-code
      class="mt-8"
      @applyDiscountCode="(e) => $emit('applyDiscountCode', e)"
      @removeDiscountCode="(e) => $emit('removeDiscountCode', e)"
      @addNameAndMessage="(e) => $emit('addNameAndMessage', e)"
      :discount-code-error="discountCodeError"
    />
    <v-button class="w-full mt-5" @click="(e) => $emit('checkoutClicked', e)">
      Checkout
    </v-button>
  </div>
</template>

<script>
import VButton from "../../Atoms/VButton";
import CartPageTotals from "./CartPageTotals";
import CartPageDiscountCode from "./CartPageDiscountCode";

export default {
  name: "CartPageSummary",
  components: {
    CartPageTotals,
    CartPageDiscountCode,
    VButton,
  },
  props: {
    cart: {
      type: Object,
      required: true,
    },
    routes: {
      type: Object,
      required: true,
    },
    discountCodeError: {
      type: String,
      default: undefined,
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
    // addNameAndMessage: {
    //   type: Object,
    //   required: true,
    // },

    // checkoutClicked: {
    //   type: Object,
    //   required: true,
    // },
  },
  methods: {
    // async checkoutClicked() {
    //   if (
    //     localStorage.getItem("name") &&
    //     localStorage.getItem("name") != "" &&
    //     localStorage.getItem("message") &&
    //     localStorage.getItem("message") != ""
    //   ) {
    //     await this.$emit("addNameAndMessage");
    //     window.location = this.routes.checkoutPath;
    //   } else {
    //     alert("Name or message can't be blank");
    //   }
    // },
  },
};
</script>
