<template>
  <svg
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    :viewBox="viewBox"
    preserveAspectRatio="xMidYMid meet"
  >
    <custom-frame-definitions
      :configuration-with-defaults="configurationWithDefaults"
      :namespace="namespace"
    />

    <rect
      :x="
        configurationWithDefaults.padding +
        configurationWithDefaults.borderWidth / 2
      "
      :y="
        configurationWithDefaults.padding +
        configurationWithDefaults.borderWidth / 2
      "
      :width="frameWidth - configurationWithDefaults.borderWidth"
      :height="frameHeight - configurationWithDefaults.borderWidth"
      :fill="`url(#mount-${namespace})`"
      :filter="`url(#frameShadow-${namespace})`"
    />

    <custom-frame-accent-mount
      v-if="configurationWithDefaults.accentMount.enabled"
      :configuration-with-defaults="configurationWithDefaults"
      :mount-dimensions-with-defaults="mountDimensionsWithDefaults"
      :upload-with-defaults="uploadWithDefaults"
      :namespace="namespace"
    />

    <custom-frame-photo
      :configuration-with-defaults="configurationWithDefaults"
      :mount-dimensions-with-defaults="mountDimensionsWithDefaults"
      :upload-with-defaults="uploadWithDefaults"
      :namespace="namespace"
    />

    <custom-frame-mount-border
      :configuration-with-defaults="configurationWithDefaults"
      :mount-dimensions-with-defaults="mountDimensionsWithDefaults"
      :upload-with-defaults="uploadWithDefaults"
      :namespace="namespace"
    />

    <custom-frame-accent-mount-external-border
      v-if="configurationWithDefaults.accentMount.enabled"
      :configuration-with-defaults="configurationWithDefaults"
      :mount-dimensions-with-defaults="mountDimensionsWithDefaults"
      :upload-with-defaults="uploadWithDefaults"
      :namespace="namespace"
    />

    <custom-frame-foil-blocking
      :configuration-with-defaults="configurationWithDefaults"
      :mount-dimensions-with-defaults="mountDimensionsWithDefaults"
      :upload-with-defaults="uploadWithDefaults"
      :foil-blocking-options="foilBlockingOptions"
      :frame-width="frameWidth"
    />

    <custom-frame-moulding
      :configuration-with-defaults="configurationWithDefaults"
      :namespace="namespace"
      :frame-width="frameWidth"
      :frame-height="frameHeight"
    />
  </svg>
</template>

<script>
import CustomFrameDefinitions from "./CustomFrameDefinitions";
import CustomFramePhoto from "./CustomFramePhoto";
import CustomFrameAccentMount from "./CustomFrameAccentMount";
import CustomFrameMoulding from "./CustomFrameMoulding";
import CustomFrameFoilBlocking from "./CustomFrameFoilBlocking";
import CustomFrameMountBorder from "./CustomFrameMountBorder";
import CustomFrameAccentMountExternalBorder from "./CustomFrameAccentMountExternalBorder";

const placeholderUrl = require("../../images/photo-placeholder.jpg");
const placeholderWidth = 20;
const placeholderHeight = 30;
const placeholderBorderPattern = require("../../images/border-pattern-placeholder.jpg");
const placeholderBorderWidth = 2.5;
const placeholderBorderPatternRepeats = 5.2;
const placeholderMountPattern = require("../../images/mount-pattern-placeholder.jpg");
const placeholderMountPatternWidth = 0.1;
const placeholderMountPatternHeight = 0.1;
const placeholderApplyMountShadow = false;
const placeholderApplyMountBorder = false;
const placeholderMountBorderWidth = 0.2;
const placeholderMountBorderTopLeftWidth = 0.5;
const placeholderMountBorderTopLeftHeight = 0.2;
const placeholderMountBorderTopLeft = require("../../images/mount-border-top-left-placeholder.jpg");
const placeholderMountBorderBottomRightWidth = 0.5;
const placeholderMountBorderBottomRightHeight = 0.2;
const placeholderMountBorderBottomRight = require("../../images/mount-border-bottom-right-placeholder.jpg");
const placeholderPadding = 5;
const placeholderAccentMountWidth = 0.4;
const placeholderMountSize = 6;

export default {
  name: "CustomFramePreview",
  components: {
    CustomFrameDefinitions,
    CustomFramePhoto,
    CustomFrameAccentMount,
    CustomFrameMoulding,
    CustomFrameFoilBlocking,
    CustomFrameMountBorder,
    CustomFrameAccentMountExternalBorder,
  },
  props: {
    namespace: {
      type: String,
      default: "0",
    },
    mountDimensions: {
      type: Object,
      required: true,
    },
    upload: {
      type: Object,
      default: undefined,
    },
    foilBlockingOptions: {
      type: Object,
      required: true,
    },
    enableShadows: {
      type: Boolean,
      default: true,
    },
    configuration: {
      type: Object,
      default() {
        return {};
      },
    },
  },
  computed: {
    configurationWithDefaults() {
      let result = {};
      result.borderPattern =
        this.configuration.borderPattern || placeholderBorderPattern;
      result.borderWidth =
        parseFloat(this.configuration.borderWidth) || placeholderBorderWidth;
      result.borderPatternRepeats =
        parseFloat(this.configuration.borderPatternRepeats) ||
        placeholderBorderPatternRepeats;
      result.mountPattern =
        this.configuration.mountPattern || placeholderMountPattern;
      result.mountPatternWidth =
        parseFloat(this.configuration.mountPatternWidth) ||
        placeholderMountPatternWidth;
      result.mountPatternHeight =
        parseFloat(this.configuration.mountPatternHeight) ||
        placeholderMountPatternHeight;
      result.applyMountShadow =
        this.configuration.applyMountShadow || placeholderApplyMountShadow;
      result.applyMountBorder =
        this.configuration.applyMountBorder || placeholderApplyMountBorder;
      (result.mountBorderWidth =
        this.configuration.mountBorderWidth || placeholderMountBorderWidth),
        (result.mountBorderTopLeftWidth =
          this.configuration.mountBorderTopLeftWidth ||
          placeholderMountBorderTopLeftWidth);
      result.mountBorderTopLeftHeight =
        this.configuration.mountBorderTopLeftHeight ||
        placeholderMountBorderTopLeftHeight;
      result.mountBorderTopLeft =
        this.configuration.mountBorderTopLeft || placeholderMountBorderTopLeft;
      result.mountBorderBottomRightWidth =
        this.configuration.mountBorderBottomRightWidth ||
        placeholderMountBorderBottomRightWidth;
      result.mountBorderBottomRightHeight =
        this.configuration.mountBorderBottomRightHeight ||
        placeholderMountBorderBottomRightHeight;
      result.mountBorderBottomRight =
        this.configuration.mountBorderBottomRight ||
        placeholderMountBorderBottomRight;
      result.padding = this.configuration.padding || placeholderPadding;
      result.enableShadows = this.configuration.enableShadows !== false;
      result.accentMountWidth =
        this.configuration.accentMountWidth || placeholderAccentMountWidth;
      result.accentMount = this.configuration.accentMount || {};
      if (this.configuration.accentMount) {
        result.accentMount.mountBorderTopLeftWidth =
          this.configuration.accentMount.mountBorderTopLeftWidth ||
          placeholderMountBorderTopLeftWidth;
        result.accentMount.mountBorderTopLeftHeight =
          this.configuration.accentMount.mountBorderTopLeftHeight ||
          placeholderMountBorderTopLeftHeight;
        result.accentMount.mountBorderTopLeft =
          this.configuration.accentMount.mountBorderTopLeft ||
          placeholderMountBorderTopLeft;
        result.accentMount.mountBorderBottomRightWidth =
          this.configuration.accentMount.mountBorderBottomRightWidth ||
          placeholderMountBorderBottomRightWidth;
        result.accentMount.mountBorderBottomRightHeight =
          this.configuration.accentMount.mountBorderBottomRightHeight ||
          placeholderMountBorderBottomRightHeight;
        result.accentMount.mountBorderBottomRight =
          this.configuration.accentMount.mountBorderBottomRight ||
          placeholderMountBorderBottomRight;
        result.accentMount.enabled = true;
      } else {
        result.accentMount.mountBorderTopLeftWidth =
          placeholderMountBorderTopLeftWidth;
        result.accentMount.mountBorderTopLeftHeight =
          placeholderMountBorderTopLeftHeight;
        result.accentMount.mountBorderTopLeft = placeholderMountBorderTopLeft;
        result.accentMount.mountBorderBottomRightWidth =
          placeholderMountBorderBottomRightWidth;
        result.accentMount.mountBorderBottomRightHeight =
          placeholderMountBorderBottomRightHeight;
        result.accentMount.mountBorderBottomRight =
          placeholderMountBorderBottomRight;
      }
      return result;
    },
    uploadWithDefaults() {
      if (!this.upload) {
        return {
          photoUrl: placeholderUrl,
          printWidth: placeholderWidth,
          printHeight: placeholderHeight,
        };
      }

      return {
        photoUrl: this.upload.photoUrl || placeholderUrl,
        printWidth: parseFloat(this.upload.printWidth) || placeholderWidth,
        printHeight: parseFloat(this.upload.printHeight) || placeholderHeight,
      };
    },
    mountDimensionsWithDefaults() {
      return {
        top: parseFloat(this.mountDimensions.top),
        left: parseFloat(this.mountDimensions.left),
        right: parseFloat(this.mountDimensions.right),
        bottom: parseFloat(this.mountDimensions.bottom),
      };
    },
    mountPresent() {
      const { left, right, top, bottom } = this.mountDimensionsWithDefaults;
      return !(left === 0 && right === 0 && top === 0 && bottom === 0);
    },
    viewBox() {
      return `0 0 ${
        this.frameWidth + 2 * this.configurationWithDefaults.padding
      } ${this.frameHeight + 2 * this.configurationWithDefaults.padding}`;
    },
    frameWidth() {
      const components = [
        this.mountDimensionsWithDefaults.left,
        this.photoWidth,
        this.mountDimensionsWithDefaults.right,
        2 * this.configurationWithDefaults.borderWidth,
      ];

      if (this.mountPresent) {
        components.push(2 * this.configurationWithDefaults.mountBorderWidth);
      }

      if (this.configurationWithDefaults.accentMount.enabled) {
        components.push(2 * this.configurationWithDefaults.accentMountWidth);
      }

      return components.reduce((prev, curr) => prev + curr);
    },
    frameHeight() {
      const components = [
        this.mountDimensionsWithDefaults.top,
        this.photoHeight,
        this.mountDimensionsWithDefaults.bottom,
        2 * this.configurationWithDefaults.borderWidth,
      ];

      if (this.mountPresent) {
        components.push(2 * this.configurationWithDefaults.mountBorderWidth);
      }

      if (this.configurationWithDefaults.accentMount.enabled) {
        components.push(2 * this.configurationWithDefaults.accentMountWidth);
      }

      return components.reduce((prev, curr) => prev + curr);
    },
    photoWidth() {
      return this.uploadWithDefaults.printWidth;
    },
    photoHeight() {
      return this.uploadWithDefaults.printHeight;
    },
  },
};
</script>
