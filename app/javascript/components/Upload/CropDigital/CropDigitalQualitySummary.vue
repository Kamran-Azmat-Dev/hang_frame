<template>
  <div>
    <v-p :body-size="1" class="text-center">
      Your image quality is <strong> {{ dpi }}dpi </strong> for a
      <strong
        >{{ parseFloat(printSize.value.width).toFixed(1) }}x{{
          parseFloat(printSize.value.height).toFixed(1)
        }}cm</strong
      >
      print.
    </v-p>
    <crop-digital-quality-meter
      class="w-full max-w-90 mt-16 mb-10"
      :dpi="dpi"
    />
  </div>
</template>

<script>
import CropDigitalQualityMeter from "./CropDigitalQualityMeter";
import VP from "../../Atoms/VP";

export default {
  name: "CropQualitySummary",
  components: {
    CropDigitalQualityMeter,
    VP,
  },
  props: {
    croppedSize: {
      type: Object,
      required: true,
    },
    printSize: {
      type: Object,
      required: true,
    },
  },
  computed: {
    dpi() {
      const inchToCm = 2.54;
      const horizontalDpi =
        (this.croppedSize.width * inchToCm) /
        parseFloat(this.printSize.value.width);
      const verticalDpi =
        (this.croppedSize.height * inchToCm) /
        parseFloat(this.printSize.value.height);

      const minDpi = Math.min(horizontalDpi, verticalDpi);
      return Math.floor(minDpi);
    },
  },
};
</script>
