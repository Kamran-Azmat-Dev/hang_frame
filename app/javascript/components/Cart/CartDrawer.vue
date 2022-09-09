<template>
  <div>
    <div
      class="fixed top-0 left-0 right-0 bottom-0 z-40 bg-grey opacity-50"
      @click="$emit('hideCartDrawer')"
    />
    <div class="fixed top-0 bottom-0 right-0 left-0 md:left-unset bg-white md:w-115 z-50 py-12 md:py-24 px-6 md:px-17 flex flex-col">
      <cart-header
        @hideCartDrawer="$emit('hideCartDrawer')"
        :cart="cart"
      />
      <cart-loading
        v-if="isCartLoading"
        class="mt-19 mx-auto"
      />
      <cart-loading-error
        v-else-if="isCartLoadingError"
        class="mt-19 mx-auto"
        @tryAgain="fetchCartContent"
      />
      <cart-empty-content
        v-else-if="isCartEmpty"
        class="mt-19 mx-auto"
        :all-products-path="routes.allProductsPath"
      />
      <cart-drawer-content
        v-else
        class="mx-auto"
        :cart="cart"
        :cart-path="routes.cartPath"
        @removeItem="removeCartItem"
        @duplicateItem="duplicateCartItem"
      />
    </div>
  </div>
</template>

<script>
import CartHeader from './CartHeader'
import CartDrawerContent from './Drawer/CartDrawerContent'
import CartEmptyContent from './CartEmptyContent'
import CartLoading from './CartLoading'
import CartLoadingError from './CartLoadingError'
import { ensureCart, fetchCart, removeItem } from '../../lib/api/cart'

export default {
  name: 'CartDrawer',
  components: {
    CartHeader,
    CartDrawerContent,
    CartEmptyContent,
    CartLoading,
    CartLoadingError,
  },
  props: {
    routes: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      cart: undefined,
      isCartLoading: true,
      isCartLoadingError: false,
      isCartUpdating: false,
    }
  },
  async mounted() {
    document.body.classList.add('overflow-hidden')
    await this.fetchCartContent()
  },
  beforeDestroy() {
    document.body.classList.remove('overflow-hidden')
  },
  computed: {
    isCartEmpty() {
      if (!this.cart) {
        return true
      }

      return this.cart.lineItems.length === 0
    }
  },
  methods: {
    async fetchCartContent() {
      this.isCartLoading = true
      this.isCartLoadingError = false

      try {
        this.cart = await fetchCart(this.routes)
        this.$emit('updateCartCount', this.cart.framesItemsCount)
      } catch (e) {
        this.isCartLoadingError = true
        console.error(e)
      } finally {
        this.isCartLoading = false
      }
    },
    async removeCartItem(item) {
      if (this.isCartUpdating) {
        return
      }

      this.isCartUpdating = true
      this.isCartLoadingError = false

      try {
        const { token } = await ensureCart(this.routes)
        await removeItem(this.routes, item, token)
        this.cart = await fetchCart(this.routes, token)
        this.$emit('updateCartCount', this.cart.framesItemsCount)
      } catch (e) {
        this.isCartLoadingError = true
        console.error(e)
      } finally {
        this.isCartUpdating = false
      }
    },
    duplicateCartItem(item) {
      if (item.hangPhoto.uploadType === 'original') {
        window.location = this.routes.originalArtUploadPath + '?clone_line_item_id=' + item.id
      } else {
        window.location = this.routes.digitalUploadPath + '?clone_line_item_id=' + item.id
      }
    }
  }
}
</script>
