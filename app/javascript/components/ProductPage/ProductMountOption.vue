<template>
  <div
    class="flex flex-col items-center cursor-pointer"
    @click="$emit('click')"
  >
    <div
      class="w-14 h-14 rounded-full flex items-center"
      :class="iconContainerClasses"
    >
      <img
        class="h-6 w-6 mx-auto"
        :class="iconClasses"
        :src="iconSrc"
      />
    </div>
    <v-p
      class="text-center text-grey mt-2"
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

export default {
  name: 'ProductMountOption',
  components: {
    VP,
  },
  props: {
    label: {
      type: String,
      required: true,
    },
    icon: {
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
  computed: {
    iconContainerClasses() {
      if (this.selected) {
        return ['bg-grey']
      }
    },
    iconClasses() {
      if (this.selected) {
        return ['product-mount-option__icon--selected']
      }
    },
    iconSrc() {
      return require(`../../images/mount-${this.icon}.svg`)
    }
  }
}
</script>

<style scoped>
.product-mount-option__icon--selected {
  filter: brightness(0) invert(1);
}
</style>
