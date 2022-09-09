<template>
  <g>
    <text
      v-if="foilBlockingOptions.chosen && foilBlockingOptions.line1"
      :x="viewportCenterX"
      :y="line1Y"
      text-anchor="middle"
      font-size="1"
      font-family="Courier, serif"
      :fill="foilBlockingOptions.color.display"
    >
      {{ foilBlockingOptions.line1 }}
    </text>

    <text
      v-if="foilBlockingOptions.chosen && foilBlockingOptions.line2"
      :x="viewportCenterX"
      :y="line2Y"
      text-anchor="middle"
      font-size="1"
      font-family="Courier, serif"
      :fill="foilBlockingOptions.color.display"
    >
      {{ foilBlockingOptions.line2 }}
    </text>
  </g>
</template>

<script>
export default {
  name: "CustomFrameFoilBlocking",
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
    foilBlockingOptions: {
      type: Object,
      required: true,
    },
    frameWidth: {
      type: Number,
      required: true,
    },
  },
  computed: {
    viewportCenterX() {
      return this.configurationWithDefaults.padding + this.frameWidth / 2;
    },
    photoWidth() {
      return this.uploadWithDefaults.printWidth;
    },
    photoHeight() {
      return this.uploadWithDefaults.printHeight;
    },
    line1Y() {
      const offset = 1.8;
      const {
        configurationWithDefaults,
        mountDimensionsWithDefaults,
        photoHeight,
      } = this;
      const components = [
        configurationWithDefaults.padding,
        configurationWithDefaults.borderWidth,
        mountDimensionsWithDefaults.top,
        photoHeight,
        offset,
      ];

      if (configurationWithDefaults.accentMount.enabled) {
        components.push(2 * configurationWithDefaults.accentMountWidth);
      }

      return components.reduce((prev, curr) => prev + curr);
    },
    line2Y() {
      return this.line1Y + 1.05;
    },
  },
};
</script>
