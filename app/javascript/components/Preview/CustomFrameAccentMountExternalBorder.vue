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
        :fill="`url(#mountBorderTop-${namespace})`"
        :points="topMountBorderPoints"
      />
    </svg>

    <svg
      :viewBox="`0 0 ${verticalBorderWidth} ${verticalBorderHeight}`"
      :x="leftX"
      :y="topY"
      :width="verticalBorderWidth"
      :height="verticalBorderHeight"
    >
      <polygon
        fillRule="nonzero"
        :fill="`url(#mountBorderLeft-${namespace})`"
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
        :fill="`url(#mountBorderBottom-${namespace})`"
        :points="bottomMountBorderPoints"
      />
    </svg>

    <svg
      :viewBox="`0 0 ${verticalBorderWidth} ${verticalBorderHeight}`"
      :x="rightX"
      :y="topY"
      :width="verticalBorderWidth"
      :height="verticalBorderHeight"
    >
      <polygon
        fillRule="nonzero"
        :fill="`url(#mountBorderRight-${namespace})`"
        :points="rightMountBorderPoints"
      />
    </svg>
  </g>
</template>

<script>
export default {
  name: 'CustomFrameMountExternalBorder',
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
        -configurationWithDefaults.accentMountWidth,
      ]

      return components.reduce((prev, curr) => prev + curr)
    },
    rightX() {
      const { configurationWithDefaults, mountDimensionsWithDefaults, photoWidth } = this
      const components = [
        configurationWithDefaults.padding,
        configurationWithDefaults.borderWidth,
        mountDimensionsWithDefaults.left,
        photoWidth,
        -configurationWithDefaults.mountBorderWidth,
      ]

      return components.reduce((prev, curr) => prev + curr)
    },
    topY() {
      const { configurationWithDefaults, mountDimensionsWithDefaults } = this
      const components = [
        configurationWithDefaults.padding,
        configurationWithDefaults.borderWidth,
        mountDimensionsWithDefaults.top,
        -configurationWithDefaults.accentMountWidth,
      ]

      return components.reduce((prev, curr) => prev + curr)
    },
    bottomY() {
      const { configurationWithDefaults, mountDimensionsWithDefaults, photoHeight } = this
      const components = [
        configurationWithDefaults.padding,
        configurationWithDefaults.borderWidth,
        mountDimensionsWithDefaults.top,
        photoHeight,
        -configurationWithDefaults.mountBorderWidth,
      ]

      return components.reduce((prev, curr) => prev + curr)
    },
    horizontalBorderHeight() {
      return this.configurationWithDefaults.mountBorderWidth
    },
    horizontalBorderWidth() {
      return this.photoWidth + 2 * this.configurationWithDefaults.accentMountWidth + 4 * this.configurationWithDefaults.mountBorderWidth
    },
    verticalBorderHeight() {
      return this.photoHeight + 2 * this.configurationWithDefaults.accentMountWidth + 4 * this.configurationWithDefaults.mountBorderWidth
    },
    verticalBorderWidth() {
      return this.configurationWithDefaults.mountBorderWidth
    },
    photoWidth() {
      return this.uploadWithDefaults.printWidth + 2 * this.configurationWithDefaults.mountBorderWidth + 2 * this.configurationWithDefaults.accentMountWidth
    },
    photoHeight() {
      return this.uploadWithDefaults.printHeight + 2 * this.configurationWithDefaults.mountBorderWidth + 2 * this.configurationWithDefaults.accentMountWidth
    },
  }
}
</script>
