<template>
  <g v-if="configurationWithDefaults.applyMountBorder">
    <svg
      :viewBox="`0 0 ${horizontalBorderWidth} ${horizontalBorderHeight}`"
      :x="leftX"
      :y="topY"
      :width="horizontalBorderWidth"
      :height="horizontalBorderHeight"
    >
      <polygon
        fillRule="nonzero"
        :fill="`url(#${mountNamePrefix}Top-${namespace})`"
        :points="topMountBorderPoints"
      />
    </svg>

    <svg
      :viewBox="`0 0 ${verticalBorderWidth} ${photoHeight + 2 * configurationWithDefaults.mountBorderWidth}`"
      :x="leftX"
      :y="topY"
      :width="verticalBorderWidth"
      :height="verticalBorderHeight"
    >
      <polygon
        fillRule="nonzero"
        :fill="`url(#${mountNamePrefix}Left-${namespace})`"
        :points="leftMountBorderPoints"
      />
    </svg>

    <svg
      :viewBox="`0 0 ${horizontalBorderWidth} ${horizontalBorderHeight}`"
      :x="leftX"
      :y="bottomY"
      :width="horizontalBorderWidth"
      :height="horizontalBorderHeight"
    >
      <polygon
        fillRule="nonzero"
        :fill="`url(#${mountNamePrefix}Bottom-${namespace})`"
        :points="bottomMountBorderPoints"
      />
    </svg>

    <svg
      :viewBox="`0 0 ${verticalBorderWidth} ${photoHeight + 2 * configurationWithDefaults.mountBorderWidth}`"
      :x="rightX"
      :y="topY"
      :width="verticalBorderWidth"
      :height="verticalBorderHeight"
    >
      <polygon
        fillRule="nonzero"
        :fill="`url(#${mountNamePrefix}Right-${namespace})`"
        :points="rightMountBorderPoints"
      />
    </svg>
  </g>
</template>

<script>
export default {
  name: 'CustomFrameMountBorder',
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
    topMountBorderPoints() {
      const { configurationWithDefaults } = this
      const borderWidth = configurationWithDefaults.mountBorderWidth

      const points = [
        [0, 0],
        [borderWidth, borderWidth],
        [borderWidth + this.photoWidth, borderWidth],
        [2 * borderWidth + this.photoWidth, 0]
      ]

      return points.map(e => e.join(',')).join(' ')
    },
    leftMountBorderPoints() {
      const { configurationWithDefaults } = this
      const borderWidth = configurationWithDefaults.mountBorderWidth

      const points = [
        [0, 0],
        [borderWidth, borderWidth],
        [borderWidth, borderWidth + this.photoHeight],
        [0, 2 * borderWidth + this.photoHeight]
      ]

      return points.map(e => e.join(',')).join(' ')
    },
    bottomMountBorderPoints() {
      const { configurationWithDefaults } = this
      const borderWidth = configurationWithDefaults.mountBorderWidth

      const points = [
        [0, borderWidth],
        [borderWidth, 0],
        [borderWidth + this.photoWidth, 0],
        [2 * borderWidth + this.photoWidth, borderWidth]
      ]

      return points.map(e => e.join(',')).join(' ')
    },
    rightMountBorderPoints() {
      const { configurationWithDefaults } = this
      const borderWidth = configurationWithDefaults.mountBorderWidth

      const points = [
        [0, borderWidth],
        [borderWidth, 0],
        [borderWidth,  2 * borderWidth + this.photoHeight],
        [0, borderWidth + this.photoHeight]
      ]

      return points.map(e => e.join(',')).join(' ')
    },
    leftX() {
      const { configurationWithDefaults, mountDimensionsWithDefaults } = this
      const components = [
        configurationWithDefaults.padding,
        configurationWithDefaults.borderWidth,
        mountDimensionsWithDefaults.left,
        -configurationWithDefaults.mountBorderWidth,
      ]

      if (configurationWithDefaults.accentMount.enabled) {
        components.push(configurationWithDefaults.accentMountWidth)
      }

      return components.reduce((prev, curr) => prev + curr)
    },
    rightX() {
      const { configurationWithDefaults, mountDimensionsWithDefaults, photoWidth } = this
      const components = [
        configurationWithDefaults.padding,
        configurationWithDefaults.borderWidth,
        mountDimensionsWithDefaults.left,
        photoWidth,
      ]

      if (configurationWithDefaults.accentMount.enabled) {
        components.push(configurationWithDefaults.accentMountWidth)
      }

      return components.reduce((prev, curr) => prev + curr)
    },
    topY() {
      const { configurationWithDefaults, mountDimensionsWithDefaults } = this
      const components = [
        configurationWithDefaults.padding,
        configurationWithDefaults.borderWidth,
        mountDimensionsWithDefaults.top,
        -configurationWithDefaults.mountBorderWidth,
      ]

      if (configurationWithDefaults.accentMount.enabled) {
        components.push(configurationWithDefaults.accentMountWidth)
      }

      return components.reduce((prev, curr) => prev + curr)
    },
    bottomY() {
      const { configurationWithDefaults, mountDimensionsWithDefaults, photoHeight } = this
      const components = [
        configurationWithDefaults.padding,
        configurationWithDefaults.borderWidth,
        mountDimensionsWithDefaults.top,
        photoHeight
      ]

      if (configurationWithDefaults.accentMount.enabled) {
        components.push(configurationWithDefaults.accentMountWidth)
      }

      return components.reduce((prev, curr) => prev + curr)
    },
    horizontalBorderHeight() {
      return this.configurationWithDefaults.mountBorderWidth
    },
    horizontalBorderWidth() {
      return this.photoWidth + 2 * this.configurationWithDefaults.mountBorderWidth
    },
    verticalBorderHeight() {
      return this.photoHeight + 2 * this.configurationWithDefaults.mountBorderWidth
    },
    verticalBorderWidth() {
      return this.configurationWithDefaults.mountBorderWidth
    },
    photoWidth() {
      return this.uploadWithDefaults.printWidth
    },
    photoHeight() {
      return this.uploadWithDefaults.printHeight
    },
    mountNamePrefix() {
      return this.configurationWithDefaults.accentMount.enabled ? 'accentMountBorder' : 'mountBorder'
    },
  }
}
</script>
