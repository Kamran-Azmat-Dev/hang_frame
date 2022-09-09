<template>
  <g>
    <svg
      v-if="configurationWithDefaults.enableShadows"
      :viewBox="`0 0 ${frameWidth} ${frameHeight}`"
      :x="configurationWithDefaults.padding"
      :y="configurationWithDefaults.padding"
      :width="frameWidth"
      :height="frameHeight"
    >
      <polygon
        fill="black"
        :filter="`url(#topFrameShadow-${namespace})`"
        :points="topBorderPoints"
      />

      <polygon
        fill="black"
        :filter="`url(#leftFrameShadow-${namespace})`"
        :points="leftBorderPoints"
      />
    </svg>

    <svg
      :viewBox="`0 0 ${frameWidth} ${configurationWithDefaults.borderWidth}`"
      :x="configurationWithDefaults.padding"
      :y="configurationWithDefaults.padding"
      :width="frameWidth"
      :height="configurationWithDefaults.borderWidth"
    >
      <polygon
        fillRule="nonzero"
        :fill="`url(#frameTop-${namespace})`"
        :points="topBorderPoints"
      />
    </svg>

    <svg
      :viewBox="`0 0 ${configurationWithDefaults.borderWidth} ${frameHeight}`"
      :x="configurationWithDefaults.padding"
      :y="configurationWithDefaults.padding"
      :width="configurationWithDefaults.borderWidth"
      :height="frameHeight"
    >
      <polygon
        fillRule="nonzero"
        :fill="`url(#frameLeft-${namespace})`"
        :points="leftBorderPoints"
      />
    </svg>

    <svg
      :viewBox="`0 0 ${frameWidth} ${configurationWithDefaults.borderWidth}`"
      :x="configurationWithDefaults.padding"
      :y="configurationWithDefaults.padding + frameHeight - configurationWithDefaults.borderWidth"
      :width="frameWidth"
      :height="configurationWithDefaults.borderWidth"
    >
      <polygon
        fillRule="nonzero"
        :fill="`url(#frameBottom-${namespace})`"
        :points="bottomBorderPoints"
      />
    </svg>
    <svg
      :viewBox="`0 0 ${configurationWithDefaults.borderWidth} ${frameHeight}`"
      :x="configurationWithDefaults.padding + frameWidth - configurationWithDefaults.borderWidth"
      :y="configurationWithDefaults.padding"
      :width="configurationWithDefaults.borderWidth"
      :height="frameHeight"
    >
      <polygon
        fillRule="nonzero"
        :fill="`url(#frameRight-${namespace})`"
        :points="rightBorderPoints"
      />
    </svg>
  </g>
</template>

<script>
export default {
  name: 'CustomFrameMoulding',
  props: {
    configurationWithDefaults: {
      type: Object,
      required: true,
    },
    namespace: {
      type: String,
      required: true,
    },
    frameWidth: {
      type: Number,
      required: true,
    },
    frameHeight: {
      type: Number,
      required: true,
    },
  },
  computed: {
    topBorderPoints() {
      const { configurationWithDefaults, frameWidth } = this
      const points = [
        [0, 0],
        [configurationWithDefaults.borderWidth, configurationWithDefaults.borderWidth],
        [frameWidth - configurationWithDefaults.borderWidth, configurationWithDefaults.borderWidth],
        [frameWidth, 0]
      ]

      return points.map(e => e.join(',')).join(' ')
    },
    bottomBorderPoints() {
      const { configurationWithDefaults, frameWidth } = this
      const points = [
        [0, configurationWithDefaults.borderWidth],
        [frameWidth, configurationWithDefaults.borderWidth],
        [frameWidth - configurationWithDefaults.borderWidth, 0],
        [configurationWithDefaults.borderWidth, 0]
      ]

      return points.map(e => e.join(',')).join(' ')
    },
    leftBorderPoints() {
      const { configurationWithDefaults, frameHeight } = this
      const points = [
        [0, 0],
        [configurationWithDefaults.borderWidth, configurationWithDefaults.borderWidth],
        [configurationWithDefaults.borderWidth, frameHeight - configurationWithDefaults.borderWidth],
        [0, frameHeight]
      ]

      return points.map(e => e.join(',')).join(' ')
    },
    rightBorderPoints() {
      const borderWidth = this.configurationWithDefaults.borderWidth
      const points = [
        [0, borderWidth],
        [borderWidth, 0],
        [borderWidth, this.frameHeight],
        [0, this.frameHeight - borderWidth],
      ]

      return points.map(e => e.join(',')).join(' ')
    },
  },
}
</script>
