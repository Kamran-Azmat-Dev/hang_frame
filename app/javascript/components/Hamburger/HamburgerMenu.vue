<template>
  <div class="fixed top-0 bottom-0 right-0 left-0 md:left-unset bg-white md:w-115 z-50 py-3 md:py-24 px-6 md:px-17 flex flex-col overflow-scroll">
    <hamburger-header @closeHamburgerMenu="$emit('hideHamburgerMenu')" />
    <hamburger-main-items
      class="mt-10"
      :routes="routes"
    />
    <hamburger-items class="mt-10" />
    <hamburger-account-link
      class="mt-12 -mx-6"
      title="Account"
      :url="routes.accountPath"
    />
  </div>
</template>

<script>
import HamburgerHeader from './HamburgerHeader'
import HamburgerMainItems from './HamburgerMainItems'
import HamburgerItems from './HamburgerItems'
import HamburgerAccountLink from './HamburgerAccountLink'

export default {
  name: 'HamburgerMenu',
  components: {
    HamburgerHeader,
    HamburgerMainItems,
    HamburgerItems,
    HamburgerAccountLink,
  },
  props: {
    routes: {
      type: Object,
      required: true,
    },
  },
  async mounted() {
    document.body.classList.add('overflow-hidden')
  },
  beforeDestroy() {
    document.body.classList.remove('overflow-hidden')
  },
}
</script>
