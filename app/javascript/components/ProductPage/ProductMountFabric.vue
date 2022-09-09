<template>
  <div
    class="flex flex-col items-center cursor-pointer"
    @click="$emit('click')"
  >
    <color-marker
      :color="color"
      :selected="selected"
      :selectable="true"
      :size="1"
    />
    <v-p
      class="text-grey mt-2"
      :body-size="3"
    >
      {{ label }}
    </v-p>
    <v-p
      v-if="price > 0"
      class="text-center text-grey mt-1"
      :body-size="3"
    >
      (+£{{ price }})
    </v-p>
  </div>
</template>

<script>
import VP from '../Atoms/VP'
import ColorMarker from '../Products/ColorMarker'

export default {
  name: 'ProductMountFabric',
  components: {
    VP,
    ColorMarker,
  },
  props: {
    label: {
      type: String,
      required: true,
    },
    color: {
      type: String,
      required: true,
    },
    selected: {
      type: Boolean,
      default: false,
    },
    price: {
      type: Number,
      default: 0,
    },
  },
}
</script>
