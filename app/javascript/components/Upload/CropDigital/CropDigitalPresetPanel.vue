<template>
  <div class="flex flex-col">
    <crop-digital-preset-option
      v-for="preset in presets"
      :key="preset.key"
      :label="preset.label"
      :icon="preset.key"
      :active="isActive(preset)"
      class="mt-2"
      @click="$emit('changeCropPreset', preset)"
    />
  </div>
</template>

<script>
import CropDigitalPresetOption from './CropDigitalPresetOption'

export default {
  name: 'CropDigitalPresetPanel',
  components: {
    CropDigitalPresetOption,
  },
  props: {
    presets: {
      type: Array,
      required: true,
    },
    activePreset: {
      type: Object,
      required: true,
    },
  },
  methods: {
    isActive(preset) {
      if (!this.activePreset) {
        return false
      }

      return this.activePreset.key === preset.key
    }
  }
}
</script>
