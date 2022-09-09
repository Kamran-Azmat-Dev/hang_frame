<template>
  <div class="relative py-4">
    <v-hr class="w-full" />
    <div
      class="
        absolute
        top-1/2
        left-1/2
        transform
        -translate-x-1/2 -translate-y-1/2
        bg-grey
        text-white text-xs
        uppercase
        rounded-lg
        z-10
        py-2
        px-4
      "
    >
      {{ number }} day Delivery
    </div>
  </div>
</template>

<script>
import VHr from "../Atoms/VHr";

export default {
  name: "ProductShipsInBadge",
  components: {
    VHr,
  },
  props: {
    number: {
      type: Number,
      required: true,
    },
  },
};
</script>
