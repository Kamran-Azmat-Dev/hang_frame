<template>
  <div class="grid md:grid-cols-12 gap-6">
    <div class="md:col-span-8 md:col-start-3 text-center hidden md:block">
      <v-h4>Basket</v-h4>
    </div>

    <checkout-progress
      class="-mx-6 md:mx-0 md:col-span-8 md:col-start-3 md:mt-11 py-4"
    />

    <div class="text-center mt-11 md:hidden">
      <v-h4>Basket</v-h4>
    </div>

    <div class="md:col-span-8 md:col-start-3 mt-8 md:mt-10">
      <cart-loading v-if="isCartLoading" class="mx-auto" />
      <cart-loading-error
        v-else-if="isCartLoadingError"
        class="mx-auto"
        @tryAgain="fetchCartContent"
      />
      <cart-empty-content
        v-else-if="isCartEmpty"
        class="mx-auto"
        :all-products-path="routes.allProductsPath"
      />
      <cart-page-content
        v-else
        class="mx-auto md:col-span-7 md:col-start-1"
        :cart="cart"
        :cart-path="routes.cartPath"
        :trees-for-life-product="treesForLifeProduct"
        :gift-wrap-product="giftWrapProduct"
        :pickup-product="pickupProduct"
        @editItem="editItem"
        @removeItem="removeItem"
        @duplicateItem="duplicateItem"
        @addTreesForLife="addTreesForLife"
        @removeTreesForLife="removeTreesForLife"
        @changeTreesForLifeQuantity="changeTreesForLifeQuantity"
      />
    </div>

    <v-hr
      v-if="isCartPresent"
      class="span md:col-span-8 md:col-start-3 mt-13 md:mt-18 mb-10 md:mb-0"
    />

    <cart-page-original-art
      v-if="hasOriginalArt && isCartPresent"
      class="md:col-span-6 md:col-start-3"
      :pickupProduct="pickupProduct"
      :cart="cart"
      @homePickup="homePickup"
    />

    <v-hr
      v-if="isCartPresent && hasOriginalArt"
      class="span md:col-span-8 md:col-start-3 mb-10 md:mb-0"
    />

    <cart-page-gift-wrap
      v-if="isCartPresent"
      class="gift-wrap md:col-span-5 md:col-start-3"
      :gift-wrap-product="giftWrapProduct"
      :cart="cart"
      @addGiftWrapping="addGiftWrapping"
      @removeGiftWrapping="removeGiftWrapping"
      @checkGiftWrapping="checkGiftWrapping"
    />

    <cart-page-summary
      v-if="isCartPresent"
      class="md:col-span-3 md:col-start-8"
      :cart="cart"
      :routes="routes"
      @applyDiscountCode="applyDiscountCode"
      @removeDiscountCode="removeDiscountCode"
      @addNameAndMessage="addNameAndMessage"
      :discount-code-error="discountCodeError"
      :trees-for-life-product="treesForLifeProduct"
      :gift-wrap-product="giftWrapProduct"
      :pickup-product="pickupProduct"
      @checkoutClicked="checkoutClicked"
      @checkGiftWrapping="checkGiftWrapping"
    />
  </div>
</template>

<script>
import VH4 from "../Atoms/VH4";
import VHr from "../Atoms/VHr";
import VDropdown from "../Atoms/VDropdown.vue";
import CheckoutProgress from "./CheckoutProgress";
import CartEmptyContent from "./CartEmptyContent";
import CartLoading from "./CartLoading";
import CartLoadingError from "./CartLoadingError";
import CartPageContent from "./Page/CartPageContent";
import CartPageSummary from "./Page/CartPageSummary";
import CartPageGiftWrap from "./CartPageGiftWrap.vue";
import CartPageOriginalArt from "./CartPageOriginalArt.vue";
import { fetchAvailableCustomizationOptions } from "../../lib/api/customization";
import {
  addItem,
  applyCouponCode,
  removeCouponCode,
  changeItemQuantity,
  ensureCart,
  fetchCart,
  removeItem,
  makeAddNameAndMessage,
  makeOriginalArtPackaging,
} from "../../lib/api/cart";

export default {
  name: "CartPage",
  components: {
    VH4,
    VHr,
    VDropdown,
    CheckoutProgress,
    CartEmptyContent,
    CartLoading,
    CartLoadingError,
    CartPageContent,
    CartPageSummary,
    CartPageGiftWrap,
    CartPageOriginalArt,
  },
  props: {
    routes: {
      type: Object,
      required: true,
    },
    treesForLifeProduct: {
      type: Object,
      default: undefined,
    },
    upload: {
      type: Object,
      required: true,
    },
    giftWrapProduct: {
      type: Object,
      default: undefined,
    },
    pickupProduct: {
      type: Object,
      required: true,
    },
    printSizeId: {
      type: Number,
      default: undefined,
    },
    mountColor: {
      type: Object,
      default: undefined,
    },
    accentMountColor: {
      type: Object,
      default: undefined,
    },
    mountType: {
      type: Object,
      default: undefined,
    },
    mountOption: {
      type: Object,
      default: undefined,
    },
    foilBlockingOptions: {
      type: Object,
      default: undefined,
    },
    foilBlockingAdditional: {
      type: Object,
      default: undefined,
    },
    linenChosen: {
      type: Boolean,
      default: false,
    },
    linenAdditional: {
      type: Object,
      default: undefined,
    },
    mountDimensions: {
      type: Object,
      default: undefined,
    },
    order_id: Number,
  },
  data() {
    return {
      cart: undefined,
      isCartLoading: true,
      isCartLoadingError: false,
      isCartUpdating: false,
      discountCodeError: undefined,
      giftWrappingStatus: true,
      packageStatus: true,
      hasOriginalArt: false,
      printSizeId: undefined,
    };
  },
  computed: {
    isCartEmpty() {
      if (!this.cart) {
        return true;
      }

      return this.cart.framesItemsCount === 0;
    },
    isCartPresent() {
      if (!this.cart) {
        return false;
      }

      return this.cart.framesItemsCount > 0;
    },
  },
  async mounted() {
    await this.fetchCartContent();
  },
  methods: {
    async checkoutClicked() {
      if (
        (localStorage.getItem("name") &&
          localStorage.getItem("name") != "" &&
          localStorage.getItem("message") &&
          localStorage.getItem("message") != "") ||
        localStorage.getItem("selectedOption") !== "" ||
        this.giftWrappingStatus ||
        this.packageStatus
      ) {
        await this.addNameAndMessage();
        await this.addOriginalArtPackaging();
        window.location = this.routes.checkoutPath;
      } else {
        alert("Name or message can't be blank");
      }
    },

    async checkGiftWrapping(state) {
      this.giftWrappingStatus = state;
    },

    async checkPackage(state) {
      this.packageStatus = state;
    },

    async fetchCartContent() {
      this.isCartLoadingError = false;

      try {
        this.cart = await fetchCart(this.routes);
      } catch (e) {
        this.isCartLoadingError = true;
        console.error(e);
      } finally {
          let originalArt = this.cart.lineItems.filter(item => item.hangPhoto).find(
            (item) => item.hangPhoto.uploadType === "original"
          );
          this.hasOriginalArt = originalArt ? true : false;
          this.isCartLoading = false;
      }
    },
    async removeItem(item) {
      if (this.isCartUpdating) {
        return;
      }

      this.isCartLoadingError = false;
      this.isCartUpdating = true;

      try {
        const { token } = await ensureCart(this.routes);
        await removeItem(this.routes, item, token);
        this.cart = await fetchCart(this.routes, token);
      } catch (e) {
        this.isCartLoadingError = true;
        console.error(e);
      } finally {
        this.isCartUpdating = false;
      }
    },
    async addTreesForLife() {
      if (this.isCartUpdating) {
        return;
      }

      this.isCartUpdating = true;
      this.isCartLoadingError = false;

      try {
        const { token } = await ensureCart(this.routes);
        await addItem(
          this.routes,
          this.treesForLifeProduct.variantId,
          undefined,
          token
        );
        this.cart = await fetchCart(this.routes, token);
      } catch (e) {
        console.error(e);
        this.isCartLoadingError = true;
      } finally {
        this.isCartUpdating = false;
      }
    },
    async removeTreesForLife() {
      if (this.isCartUpdating || !this.cart.treesForLifeItem) {
        return;
      }

      this.isCartUpdating = true;
      this.isCartLoadingError = false;

      try {
        const { token } = await ensureCart(this.routes);
        await removeItem(this.routes, this.cart.treesForLifeItem, token);
        this.cart = await fetchCart(this.routes, token);
      } catch (e) {
        console.error(e);
        this.isCartLoadingError = true;
      } finally {
        this.isCartUpdating = false;
      }
    },

    async addGiftWrapping() {
      if (this.isCartUpdating) {
        return;
      }
      this.isCartUpdating = true;
      this.isCartLoadingError = false;

      try {
        const { token } = await ensureCart(this.routes);
        await addItem(
          this.routes,
          this.giftWrapProduct.variantId,
          undefined,
          token
        );
        this.cart = await fetchCart(this.routes, token);
      } catch (e) {
        console.error(e);
        this.isCartLoadingError = true;
      } finally {
        this.isCartUpdating = false;
      }
    },

    async homePickup(val) {
      if (val === 1) {
        if (this.isCartUpdating) {
          return;
        }
        this.isCartUpdating = true;
        this.isCartLoadingError = false;

        try {
          const { token } = await ensureCart(this.routes);
          await addItem(
            this.routes,
            this.pickupProduct.variantId,
            undefined,
            token
          );
          this.cart = await fetchCart(this.routes, token);
        } catch (e) {
          console.error(e);
          this.isCartLoadingError = true;
        } finally {
          this.isCartUpdating = false;
        }
      } else {
        if (this.isCartUpdating || !this.cart.pickupItem) {
          return;
        }

        this.isCartUpdating = true;
        this.isCartLoadingError = false;

        try {
          const { token } = await ensureCart(this.routes);
          await removeItem(this.routes, this.cart.pickupItem, token);
          this.cart = await fetchCart(this.routes, token);
        } catch (e) {
          console.error(e);
          this.isCartLoadingError = true;
        } finally {
          this.isCartUpdating = false;
        }
      }
    },

    async addNameAndMessage() {
      if (this.isCartUpdating) {
        return;
      }
      this.isCartUpdating = true;
      this.isCartLoadingError = false;

      const { token } = await ensureCart(this.routes);
      await makeAddNameAndMessage(
        this.routes,
        this.order_id,
        token,
        localStorage.getItem("name"),
        localStorage.getItem("message")
      );
      localStorage.removeItem("name");
      localStorage.removeItem("message");
    },

    async addOriginalArtPackaging() {
      // if (this.isCartUpdating) {
      //   return;
      // }
      this.isCartUpdating = true;
      this.isCartLoadingError = false;

      const { token } = await ensureCart(this.routes);
      await makeOriginalArtPackaging(
        this.routes,
        this.order_id,
        token,
        localStorage.getItem("selectedOption")
      );
      localStorage.removeItem("selectedOption");
    },

    async removeGiftWrapping() {
      if (this.isCartUpdating || !this.cart.giftWrapItem) {
        return;
      }

      this.isCartUpdating = true;
      this.isCartLoadingError = false;

      try {
        const { token } = await ensureCart(this.routes);
        await removeItem(this.routes, this.cart.giftWrapItem, token);
        this.cart = await fetchCart(this.routes, token);
        localStorage.removeItem("name");
        localStorage.removeItem("message");
      } catch (e) {
        console.error(e);
        this.isCartLoadingError = true;
      } finally {
        this.isCartUpdating = false;
      }
    },

    async changeTreesForLifeQuantity(quantity) {
      if (this.isCartUpdating || !this.cart.treesForLifeItem) {
        return;
      }

      this.isCartUpdating = true;
      this.isCartLoadingError = false;

      try {
        const { token } = await ensureCart(this.routes);
        await changeItemQuantity(
          this.routes,
          this.cart.treesForLifeItem,
          quantity,
          token
        );
        this.cart = await fetchCart(this.routes, token);
      } catch (e) {
        console.error(e);
        this.isCartLoadingError = true;
      } finally {
        this.isCartUpdating = false;
      }
    },
    async applyDiscountCode(code) {
      if (this.isCartUpdating) {
        return;
      }
      localStorage.setItem("newDiscountCode", code);

      this.isCartUpdating = false;
      this.discountCodeError = undefined;

      try {
        const { token } = await ensureCart(this.routes);
        await applyCouponCode(this.routes, code, token);
        this.cart = await fetchCart(this.routes, token);
      } catch (e) {
        if (e.response) {
          this.discountCodeError = e.response.data.error;
        }
        console.error(e);
      } finally {
        this.isCartUpdating = false;
      }
    },

    async removeDiscountCode(code) {
      if (this.isCartUpdating) {
        return;
      }

      this.isCartUpdating = false;
      this.discountCodeError = undefined;
      let cCode = localStorage.getItem("newDiscountCode");

      try {
        const { token } = await ensureCart(this.routes);
        await removeCouponCode(this.routes, cCode, token);
        this.cart = await fetchCart(this.routes, token);
        localStorage.removeItem("newDiscountCode");
        localStorage.removeItem("discountCode");
      } catch (e) {
        if (e.response) {
          this.discountCodeError = e.response.data.error;
          this.discountCode = "";
        }
        console.error(e);
      } finally {
        this.isCartUpdating = false;
      }
    },

    async duplicateItem(item) {
      delete item.id
      const options = await fetchAvailableCustomizationOptions(
          this.routes.availableOptionsPath,
           item.hangPhoto.uuid

        );
     const printSizeId = options.printSizeId
      const newId =  Math.floor(1000 + Math.random() * 9000);
      const newItem = {...item, id : newId }
         let payloadOptions = {
           hang_photo_uuid: newItem.hangPhoto.uuid,
        };

      if (newItem.isCustom) {
        payloadOptions = {
          ...payloadOptions,
            print_size_id: printSizeId,
            mount_type_id: newItem.mountType.id,
            mount_option_id: newItem.mountOption.id,
            mount_dimensions: {
              top: newItem.mountDimensions.top,
              left: newItem.mountDimensions.left,
              bottom: newItem.mountDimensions.bottom,
              right: newItem.mountDimensions.right,
            },
            mount_color_id: newItem.mountColor.id,
          };

          if (  
            newItem.additionals.foilBlocking &&
            newItem.additionals.foilBlocking.chosen
          ) {
            payloadOptions = {
              ...payloadOptions,
              foil_blocking: {
                additional_id: newItem.additionals.foilBlocking.color.id,
                line1: newItem.additionals.foilBlocking.line1,
                line2: newItem.additionals.foilBlocking.line2,
                color: newItem.additionals.foilBlocking.color,
              },
            };
          }

          if (newItem.additionals.linenChosen) {
            payloadOptions = {
              ...payloadOptions,
              additionals: [newItem.linenAdditional.id],
            };
          }

          if (newItem.accentMountColor) {
            payloadOptions = {
              ...payloadOptions,
              accent_mount_color_id: newItem.accentMountColor.id,
            };
          }
        } else {
          if (
            newItem.additionals.foilBlocking &&
            newItem.additionals.foilBlocking.chosen
          ) {
            payloadOptions = {
              ...payloadOptions,
              foil_blocking: {
                additional_id: newItem.additionals.foilBlocking.color.id,
                line1: newItem.additionals.foilBlocking.line1,
                line2: newItem.additionals.foilBlocking.line2,
                color: newItem.additionals.foilBlocking.color,
              },
            };
          }
        }
        await addItem(this.routes, newItem.variantId, payloadOptions);
        this.cart = await fetchCart(this.routes);
    },
    async editItem(item) {
      window.location = `products/${item.productSlug}?${item.id}`
      if (this.isCartUpdating) {
        return;
      }

      this.isCartLoadingError = false;
      this.isCartUpdating = true;

      try {
        const { token } = await ensureCart(this.routes);
        await removeItem(this.routes, item, token);
        this.cart = await fetchCart(this.routes, token);
      } catch (e) {
        this.isCartLoadingError = true;
        console.error(e);
      } finally {
        this.isCartUpdating = false;
      }
    },
  },
};
</script>

<style>
.span {
  margin-bottom: 64px !important;
}
</style>
