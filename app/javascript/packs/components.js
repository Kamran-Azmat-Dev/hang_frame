import Vue from 'vue/dist/vue.esm.js'
import VueCookies from 'vue-cookies'
import TurbolinksAdapter from 'vue-turbolinks'
import VueFlicking from '@egjs/vue-flicking'
import Navbar from '../components/Navbar/Navbar'
import PageFooter from '../components/PageFooter'
import UploadStepsDigital from '../components/Upload/UploadStepsDigital'
import UploadStepsOriginalArt from '../components/Upload/UploadStepsOriginalArt'
import VButton from '../components/Atoms/VButton'
import LoadUploadPreview from '../components/Preview/LoadUploadPreview'
import ProductCard from '../components/Products/ProductCard'
import StandardProductDetails from '../components/ProductPage/StandardProductDetails'
import CustomProductDetails from '../components/ProductPage/CustomProductDetails'
import ColorMarker from '../components/Products/ColorMarker'
import CartPage from '../components/Cart/CartPage'
import StandardFramePreview from '../components/Preview/StandardFramePreview'
import CustomFramePreview from '../components/Preview/CustomFramePreview'
import VH3 from '../components/Atoms/VH3'
import VP from '../components/Atoms/VP'
import '../css/components.css'

Vue.use(VueCookies)
Vue.use(TurbolinksAdapter)
Vue.use(VueFlicking)

const sharedEventBus = new Vue()
Vue.prototype.$sharedEventBus = sharedEventBus

const globalComponents = {
  'Navbar': Navbar,
  'PageFooter': PageFooter,
  'UploadStepsDigital': UploadStepsDigital,
  'UploadStepsOriginalArt': UploadStepsOriginalArt,
  'LoadUploadPreview': LoadUploadPreview,
  'ProductCard': ProductCard,
  'CustomProductDetails': CustomProductDetails,
  'StandardProductDetails': StandardProductDetails,
  'CartPage': CartPage,
  'ColorMarker': ColorMarker,
  'StandardFramePreview': StandardFramePreview,
  'CustomFramePreview': CustomFramePreview,
  'VButton': VButton,
  'VH3': VH3,
  'VP': VP,
}

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#navbar',
    components: globalComponents
  })

  new Vue({
    el: '#footer',
    components: globalComponents
  })

  const photoUpload = document.getElementById('photo-upload')
  if (photoUpload) {
    new Vue({
      el: photoUpload,
      components: globalComponents
    })
  }

  const frames = document.getElementById('frames')
  if (frames) {
    new Vue({
      el: '#frames',
      components: globalComponents
    })
  }

  const productDetails = document.getElementById('product-details')
  if (productDetails) {
    new Vue({
      el: productDetails,
      components: globalComponents
    })
  }

  const cartPage = document.getElementById('cart-page')
  if (cartPage) {
    new Vue({
      el: cartPage,
      components: globalComponents
    })
  }

  const orderHistory = document.getElementById('order-history')
  if (orderHistory) {
    new Vue({
      el: orderHistory,
      components: globalComponents
    })
  }

  const checkoutSummary = document.getElementById('checkout-summary')
  if (checkoutSummary) {
    new Vue({
      el: checkoutSummary,
      components: globalComponents
    })
  }
})
