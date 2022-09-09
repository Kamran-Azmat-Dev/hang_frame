<template>
  <image
    :x="x"
    :y="y"
    :width="photoWidth"
    :height="photoHeight"
    :xlink:href="photoUrl"
    preserveAspectRatio="none"
    :filter="photoFilter"
  />
</template>

<script>
export default {
  name: 'CustomFramePhoto',
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
      ]

      if (this.configurationWithDefaults.accentMount.enabled) {
        components.push(this.configurationWithDefaults.accentMountWidth)
      }

      return components.reduce((prev, curr) => prev + curr)
    },
    y() {
      const { configurationWithDefaults, mountDimensionsWithDefaults } = this
      const components = [
        configurationWithDefaults.padding,
        configurationWithDefaults.borderWidth,
        mountDimensionsWithDefaults.top
      ]

      if (this.configurationWithDefaults.accentMount.enabled) {
        components.push(this.configurationWithDefaults.accentMountWidth)
      }

      return components.reduce((prev, curr) => prev + curr)
    },
    photoFilter() {
      if (this.configurationWithDefaults.applyMountShadow) {
        return `url(#photoShadow-${this.namespace})`
      }

      return undefined
    },
    photoUrl() {
      return this.uploadWithDefaults.photoUrl
    },
    photoWidth() {
      return this.uploadWithDefaults.printWidth
    },
    photoHeight() {
      return this.uploadWithDefaults.printHeight
    },
  },
}
</script>
