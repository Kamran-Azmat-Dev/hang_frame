<template>
  <div class="grid md:grid-cols-4 gap-2 trees-for-life">
    <div
      class="
        md:col-start-2 md:col-span-3
        flex flex-col
        md:flex-row md:items-end
      "
    >
      <v-checkbox
        name="donate"
        :value="treesForLifeSelected"
        @input="updateTreesForLife"
      >
        <v-p class="font-bold" :body-size="2">
          Donate a tree to
          <a
            class="underline"
            href="https://treesforlife.org.uk/"
            target="_blank"
          >
            Trees for Life
          </a>
          <span class="md:hidden font-normal text-sm"
            ><br />Donate £3 and we'll match the funding,<br />this will plant a
            tree in the Hang Grove!
          </span>
        </v-p>
      </v-checkbox>
      <div class="pl-11 price">
      <v-p class="md:pl-0 pt-2 md:pt-0 md:mx-auto flex" :body-size="2">
        Quantity
        <span class="font-bold ml-3">{{ quantity }}</span>
        <div class="flex flex-col ml-3">
          <img
            src="~images/arrow-quantity-up.svg"
            @click="increaseTreesForLifeQuantity"
          />
          <img
            src="~images/arrow-quantity-down.svg"
            class="mt-3"
            @click="decreaseTreesForLifeQuantity"
          />
        </div>
      </v-p>
      <v-p
        class="
          pl-11
          md:pl-0
          pt-2
          md:pt-0 md:ml-auto
          mr-0
          md:font-bold
          price-mobile
        "
        :body-size="2"
      >
        &#163;{{ price }}
      </v-p>
      </div>

      <v-p
        class="
          pl-11
          md:pl-0
          pt-2
          md:pt-0 md:ml-auto
          mr-0
          md:font-bold
          price-desktop
        "
        :body-size="2"
      >
        &#163;{{ price }}
      </v-p>

    </div>
    <div
      class="
        md:col-start-2 md:col-span-3
        pl-11
        md:flex
        flex-col
        md:flex-row
        hidden
      "
    >
      <v-p style="font-size: 18px; color: #1d2019; font-weight: 300">
        Donate £3 and we'll match the funding,<br />
        <p
          class="mt-2"
          style="font-size: 18px; color: #1d2019; font-weight: 300"
        >
          this will plant a tree in the Hang Grove!
        </p>
      </v-p>
    </div>
  </div>
</template>

<script>
import VP from "../../Atoms/VP";
import VCheckbox from "../../Atoms/VCheckbox";

export default {
  name: "CartPageDonate",
  components: {
    VP,
    VCheckbox,
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
  },
  computed: {
    treesForLifeSelected() {
      return this.cart.treesForLifeItem !== undefined;
    },
    quantity() {
      if (this.cart.treesForLifeItem) {
        return this.cart.treesForLifeItem.quantity;
      }
      {
        return 0;
      }
    },
    price() {
      return parseFloat(this.treesForLifeProduct.price * this.quantity).toFixed(
        2
      );
    },
  },
  methods: {
    updateTreesForLife() {
      if (this.treesForLifeSelected) {
        this.$emit("removeTreesForLife");
      } else {
        this.$emit("addTreesForLife");
      }
    },
    increaseTreesForLifeQuantity() {
      if (this.treesForLifeSelected) {
        this.$emit("changeTreesForLifeQuantity", this.quantity + 1);
      } else {
        this.$emit("addTreesForLife");
      }
    },
    decreaseTreesForLifeQuantity() {
      if (this.treesForLifeSelected && this.quantity > 1) {
        this.$emit("changeTreesForLifeQuantity", this.quantity - 1);
      } else {
        this.$emit("removeTreesForLife");
      }
    },
  },
};
</script>

<style>
  .price-mobile {
    display: none;
  }
  .price-desktop {
    display: block;
  }
@media all and (max-width: 540px) {
  .price {
    display: flex;
    justify-content: space-between;
  }
  .price-mobile {
    display: block;
  }
  .price-desktop {
    display: none;
  }
}

</style>
