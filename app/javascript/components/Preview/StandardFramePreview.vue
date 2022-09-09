<template>
  <svg
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    :viewBox="viewBox"
    preserveAspectRatio="xMidYMid slice"
  >
    <image
      v-if="framePhotoUrl"
      x="0"
      y="0"
      :width="framePhotoWidth"
      :height="framePhotoHeight"
      :xlink:href="framePhotoUrl"
    />
    <image
      v-if="framePhotoUrl && photoUrl"
      :x="relativePreviewX"
      :y="relativePreviewY"
      :width="relativePreviewWidth"
      :height="relativePreviewHeight"
      :xlink:href="photoUrl"
      preserveAspectRatio="xMidYMid slice"
    />
  </svg>
</template>

<script>
export default {
  name: "StandardFramePreview",
  props: {
    framePhotoUrl: {
      type: String,
      default: undefined,
    },
    framePhotoWidth: {
      type: Number,
      required: true,
    },
    framePhotoHeight: {
      type: Number,
      required: true,
    },
    upload: {
      type: Object,
      default: undefined,
    },
    framePreviewX: {
      type: Number,
      default: 25,
    },
    framePreviewY: {
      type: Number,
      default: 25,
    },
    framePreviewWidth: {
      type: Number,
      default: 50,
    },
    framePreviewHeight: {
      type: Number,
      default: 50,
    },
  },
  computed: {
    viewBox() {
      return `0 0 ${this.framePhotoWidth} ${this.framePhotoHeight}`;
    },
    relativePreviewX() {
      return (this.framePreviewX / 1000.0) * this.framePhotoWidth;
    },
    relativePreviewWidth() {
      return (this.framePreviewWidth / 1000.0) * this.framePhotoWidth;
    },
    relativePreviewY() {
      return (this.framePreviewY / 1000.0) * this.framePhotoHeight;
    },
    relativePreviewHeight() {
      return (this.framePreviewHeight / 1000.0) * this.framePhotoHeight;
    },
    photoUrl() {
      if (!this.upload) {
        return undefined;
      }

      return this.upload.photoUrl;
    },
  },
};
</script>
