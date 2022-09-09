<template>
  <div>
    <div
      class="
        bg-white
        shadow-sm
        w-full
        flex flex-col
        items-center
        fixed
        top-0
        z-30
      "
    >
      <div
        class="
          w-full
          max-w-screen-xl
          py-4
          px-6
          flex
          text-grey
          relative
          hng-navbar
        "
      >
        <ul class="flex-1 flex items-center text-sm">
          <li
            class="
              hidden
              md:flex
              h-full
              items-center
              mr-16
              hover:underline
              cursor-pointer
            "
            @mouseover="showStartFramingMenu"
            @mouseleave="hideStartFramingMenu"
          >
            <span class="uppercase"> Start framing </span>
            <div
              v-if="startFramingMenuVisible"
              class="absolute top-76 left-0 transform"
            >
              <navbar-start-framing-menu
                class="hidden md:flex mt-5"
                :routes="routes"
              />
            </div>
          </li>
          <li class="hidden md:block">
            <a
              class="hover:underline uppercase"
              href="https://hangframing.com/how-it-works"
            >
              How it works
            </a>
          </li>
          <li class="md:hidden">
            <div
              class="cursor-pointer w-6 h-6 flex items-center"
              @click="showHamburgerMenu"
            >
              <img
                src="~/images/menu.svg"
                class="w-6 h-4 pointer-events-none"
              />
            </div>
          </li>
        </ul>
        <a
          href="https://hangframing.com"
          class="flex-shrink-0 flex items-center hang_logo"
          ><img src="~/images/logo.svg" class="w-30 h-16 pointer-events-none"
        /></a>
        <ul class="flex-1 flex items-center text-sm uppercase">
          <li class="hidden md:block ml-auto mr-8">
            <a class="hover:underline" href="https://hangframing.com/support">
              Support
            </a>
          </li>
          <li class="ml-auto mr-0 md:ml-0 md:mr-4">
            <div class="cursor-pointer relative" @click="showCartDrawer">
              <img
                src="~/images/cart.svg"
                class="w-6 h-6 pointer-events-none"
              />
              <div
                v-if="cartCount > 0"
                class="
                  absolute
                  bottom-0
                  left-1/2
                  transform
                  -translate-x-1/2
                  translate-y-0.5
                "
              >
                {{ cartCount }}
              </div>
            </div>
          </li>
          <li class="hidden md:block">
            <a :href="routes.accountPath"
              ><img
                src="~/images/profile.svg"
                class="w-6 h-6 pointer-events-none"
            /></a>
          </li>
        </ul>
      </div>
    </div>
    <cart-drawer
      v-if="cartDrawerVisible"
      :routes="routes"
      @hideCartDrawer="hideCartDrawer"
      @updateCartCount="(value) => (cartCount = value)"
    />
    <hamburger-menu
      v-if="hamburgerMenuVisible"
      :routes="routes"
      @hideHamburgerMenu="hideHamburgerMenu"
    />
    <div class="pb-24" />
  </div>
</template>

<script>
import CartDrawer from "../Cart/CartDrawer";
import HamburgerMenu from "../Hamburger/HamburgerMenu";
import NavbarStartFramingMenu from "./NavbarStartFramingMenu";

export default {
  name: "Navbar",
  components: {
    CartDrawer,
    HamburgerMenu,
    NavbarStartFramingMenu,
  },
  props: {
    routes: {
      type: Object,
      required: true,
    },
    initialCartCount: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      hamburgerMenuVisible: false,
      cartDrawerVisible: false,
      startFramingMenuVisible: false,
      hideStartFramingMenuTimeout: undefined,
      cartCount: this.initialCartCount,
    };
  },
  created() {
    this.$sharedEventBus.$on("showCartDrawer", this.showCartDrawer);
  },
  beforeDestroy() {
    this.$sharedEventBus.$off("showCartDrawer");
  },
  methods: {
    hideAllMenus() {
      this.hamburgerMenuVisible = false;
      this.cartDrawerVisible = false;
      this.startFramingMenuVisible = false;
    },
    showHamburgerMenu() {
      this.hideAllMenus();
      this.hamburgerMenuVisible = true;
    },
    hideHamburgerMenu() {
      this.hideAllMenus();
    },
    showCartDrawer() {
      this.hideAllMenus();
      this.cartDrawerVisible = true;
    },
    hideCartDrawer() {
      this.hideAllMenus();
    },
    showStartFramingMenu() {
      this.hideAllMenus();
      this.startFramingMenuVisible = true;
      if (this.hideStartFramingMenuTimeout) {
        clearInterval(this.hideStartFramingMenuTimeout);
        this.hideStartFramingMenuTimeout = undefined;
      }
    },
    hideStartFramingMenu() {
      if (!this.hideStartFramingMenuTimeout) {
        this.hideStartFramingMenuTimeout = setInterval(() => {
          this.startFramingMenuVisible = false;
        }, 500);
      }
    },
  },
};
</script>

<style>
/* .hng-navbar {
  justify-content: space-between;
}
.hng-navbar ul {
  flex: 0 0 auto;
} */
@media all and (max-width: 540px) {
  .hang_logo {
    width: 84px;
    height: 45px;
  }
  .my_field {
    max-width: 306px;
  }
}

@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {
  .hang_logo {
    width: 84px;
    height: 45px;
  }
  .my_field {
    max-width: 306px;
  }
}
@media only screen and (min-width: 1280px) and (max-width: 767px) {
  .hang_logo {
    width: 84px;
    height: 45px;
  }
  .my_field {
    max-width: 306px;
  }
}
@media only screen and (min-device-width: 1030px) and (max-device-width: 1366px) {
  .hang_logo {
    width: 84px;
    height: 45px;
  }
  .my_field {
    max-width: 306px;
  }
}
@media only screen and (min-device-width: 360px) and (max-device-width: 640px) {
  .hang_logo {
    width: 84px;
    height: 45px;
  }
  .my_field {
    max-width: 306px;
  }
}
@media only screen and (orientation: landscape) and (-webkit-min-device-pixel-ratio: 1) and (min-device-width: 768px) and (max-device-width: 1007px) {
  .hang_logo {
    width: 84px;
    height: 45px;
  }
  .my_field {
    max-width: 306px;
  }
}
@media all and (min-width: 1024px) and (max-height: 1310px) {
  .hang_logo {
    width: 119px;
    height: 64px;
  }
  .my_field {
    max-width: 306px;
  }
}
</style>
