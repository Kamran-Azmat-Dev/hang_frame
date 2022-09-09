<template>
  <div>
    <v-h4 class="mb-8">What's included</v-h4>
    <div class="flex">
      <v-p class="ml-6" :body-size="1">
        <div class="whatIsIncluded" v-html="product.whatsIncluded"></div>
      </v-p>
    </div>
  </div>
</template>

<script>
import VH4 from "../Atoms/VH4";
import VP from "../Atoms/VP";
export default {
  name: "ProductWhatsIncluded",
  components: {
    VH4,
    VP,
  },

  props: {
    product: {
      type: Object,
      default: () => ({}),
    },
  },
  data() {
    return {};
  },
};
</script>
