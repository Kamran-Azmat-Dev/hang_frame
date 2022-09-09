<template>
  <button
    class="text-grey hover:bg-cement2 rounded-sm focus:outline-none flex items-center px-6 py-2"
    :class="classes"
    @click="$emit('click')"
  >
    <div class="w-9 h-9 flex flex-col items-center flex-shrink-0">
      <img
        :src="iconSrc"
        class="object-fill mx-auto my-auto"
      />
    </div>
    <div class="text-xl ml-4">
      {{ label }}
    </div>
  </button>
</template>

<script>
export default {
  name: 'CropDigitalPresetOption',
  props: {
    label: {
      type: String,
      required: true,
    },
    icon: {
      type: String,
      required: true,
    },
    active: {
      type: Boolean,
      required: true,
    },
  },
  computed: {
    classes() {
      if (this.active) {
        return ['bg-cement2']
      }
    },
    iconSrc() {
      return require(`../../../images/crop-preset-${this.icon}.svg`)
    }
  }
}
</script>
