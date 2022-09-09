<template>
  <div>
    <v-p v-if="discountCodeError" class="mb-2" :body-size="1">
      {{ discountCodeError }}
    </v-p>
    <v-input-with-button
      class="apply-btn"
      v-model="discountCode"
      placeholder="Discount code"
      button-label="Apply"
      @buttonClick="$emit('applyDiscountCode', discountCode)"
    />
    <v-btn
      class="
        flex-shrink-0
        tracking-wide
        text-sm
        leading-lg
        font-bold
        uppercase
        focus:outline-none
        px-4
        py-3
        ml-auto
        mr-0
        hover:underline
        remove-btn
      "
      :disabled="!discountCode"
      v-model="discountCode"
      @click="
        $emit('removeDiscountCode', discountCode);
        resetInput();
      "
    >
      Remove
    </v-btn>
  </div>
</template>

<script>
import VButton from "../../Atoms/VButton.vue";
import VInputWithButton from "../../Atoms/VInputWithButton";
import VP from "../../Atoms/VP";

export default {
  name: "CartPageDiscountCode",
  components: {
    VInputWithButton,
    VP,
    VButton,
  },
  props: {
    discountCodeError: {
      type: String,
      default: undefined,
    },
  },
  data() {
    return {
      discountCode: localStorage.getItem("newDiscountCode") || "",
    };
  },
  methods: {
    resetInput() {
      this.discountCode = "";
    },
  },
};
</script>

<style>
.remove-btn {
  cursor: pointer;
  display: flex;
  justify-content: right;
  color: #828282;
  padding: 0 !important;
  margin-right: 15px !important;
  margin-top: 15px !important;
}
.apply-btn button {
  color: #828282;
}
</style>
