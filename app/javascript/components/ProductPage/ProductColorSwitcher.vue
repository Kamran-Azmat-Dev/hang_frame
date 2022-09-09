<template>
  <div class="flex flex-wrap">
    <color-marker
      v-for="color in availableColors"
      :key="color.id"
      :color="color.value"
      :size="2"
      :selected="isSelected(color)"
      :selectable="true"
      @click="$emit('input', color)"
    />
  </div>
</template>

<script>
import ColorMarker from "../Products/ColorMarker";

export default {
  name: "ProductColorSwitcher",
  components: {
    ColorMarker,
  },
  props: {
    value: {
      type: Object,
      required: true,
    },
    availableColors: {
      type: Array,
      required: true,
    },
  },
  methods: {
    isSelected(color) {
      return color.id === this.value.id;
    },
  },
};
</script>
