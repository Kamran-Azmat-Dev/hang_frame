<template>
  <rect
    :x="x"
    :y="y"
    :width="width"
    :height="height"
    fillRule="nonzero"
    :fill="`url(#accentMount-${namespace})`"
  />
</template>

<script>
export default {
  name: 'CustomFrameAccentMount',
  props: {
    configurationWithDefaults: {
      type: Object,
      required: true,
    },
    mountDimensionsWithDefaults: {
      type: Object,
      required: true,
    },
    uploadWithDefaults: {
      type: Object,
      required: true,
    },
    namespace: {
      type: String,
      required: true,
    },
  },
  computed: {
    x() {
      const { configurationWithDefaults, mountDimensionsWithDefaults } = this
      const components = [
        configurationWithDefaults.padding,
        configurationWithDefaults.borderWidth,
        mountDimensionsWithDefaults.left,
        -configurationWithDefaults.mountBorderWidth,
      ]

      return components.reduce((prev, curr) => prev + curr)
    },
    y() {
      const { configurationWithDefaults, mountDimensionsWithDefaults } = this
      const components = [
        configurationWithDefaults.padding,
        configurationWithDefaults.borderWidth,
        mountDimensionsWithDefaults.top,
        -configurationWithDefaults.mountBorderWidth,
      ]

      return components.reduce((prev, curr) => prev + curr)
    },
    width() {
      return this.uploadWithDefaults.printWidth + 2 * this.configurationWithDefaults.accentMountWidth + 2 * this.configurationWithDefaults.mountBorderWidth
    },
    height() {
      return this.uploadWithDefaults.printHeight + 2 * this.configurationWithDefaults.accentMountWidth + 2 * this.configurationWithDefaults.mountBorderWidth
    },
  }
}
</script>
