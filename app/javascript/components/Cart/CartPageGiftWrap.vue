<template>
  <div class="grid md:grid-cols-4 gap-2">
    <div
      class="
        md:col-start-1 md:col-span-5
        flex flex-col
        md:flex-row md:items-end
      "
    >
      <v-checkbox
        class="checkbox"
        name="wrap"
        :value="giftWrapSelected"
        @input="updateGiftWrap"
      >
        <v-p class="font-bold" :body-size="2">
          <strong>Add gift note & wrapping</strong>
        </v-p>
      </v-checkbox>

      <v-p
        class="
          md:pl-0
          pt-2
          md:pt-0
          lg:ml-30
          mr-0
          md:font-bold
          gift_wrapped
        "
        :body-size="2"
      >
        &#163;{{ price }}
      </v-p>
    </div>
    <form id="aaaa">
      <v-input
        name="name"
        id="setName"
        value=""
        v-model="name"
        class="rec-name mt-5"
        placeholder="Recipient name"
        :disabled="giftWrapSelected ? false : true"
      />
      <textarea
        class="
          desc
          px-4
          py-3
          mb-2
          mt-4
          md:text-lg md:leading-lg
          border border-grey50
          text-grey
          rounded-sm
          focus:outline-none focus:border-grey
          disabled:text-grey50
        "
        placeholder="Gift message (max. 300 characters)"
        maxlength="300"
        name="message"
        id="setMessage"
        value=""
        v-model="message"
        :disabled="giftWrapSelected ? false : true"
      />
    </form>
  </div>
</template>

<script>
import VP from "../Atoms/VP";
import VCheckbox from "../Atoms/VCheckbox";
import VInput from "../Atoms/VInput";

export default {
  name: "CartPageGiftWrap",
  data() {
    return {
      name: "",
      message: "",
      errors: [],
    };
  },
  components: {
    VP,
    VCheckbox,
    VInput,
  },
  props: {
    cart: {
      type: Object,
      required: true,
    },
    giftWrapProduct: {
      type: Object,
      required: true,
    },
  },
  computed: {
    giftWrapSelected() {
      return this.cart.giftWrapItem !== undefined;
    },
    price() {
      return parseFloat(this.giftWrapProduct.price).toFixed(2);
    },
  },
  methods: {
    async updateGiftWrap() {
      if (this.giftWrapSelected) {
        await this.$emit("removeGiftWrapping");
      } else {
        await this.$emit("addGiftWrapping");
      }
      await this.$emit("checkGiftWrapping", this.giftWrapSelected);
    },
  },
  watch: {
    name: function (val) {
      localStorage.setItem("name", val);
    },
    message: function (val) {
      localStorage.setItem("message", val);
    },
  },
};
</script>

<style>
.rec-name {
  width: 392px;
}
.desc {
  width: 392px;
  height: 170px;
}
@media all and (max-width: 992px) {
  .rec-name {
    width: 100%;
  }
  .desc {
    width: 100%;
    height: 170px;
  }
}
@media all and (max-width: 575px) {
  .rec-name {
    width: 100%;
    /* max-width: 300px; */
  }
  .desc {
    width: 100%;
    /* max-width: 300px; */
    height: 170px;
  }
}
@media all and (max-width: 540px) {
  .gift_wrapped {
    margin-left: 20rem !important;
    margin-top: -2rem !important;
  }
}
</style>
