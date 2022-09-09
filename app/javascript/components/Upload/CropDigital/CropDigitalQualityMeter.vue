<template>
  <div>
    <div class="pt-32 pb-4">
      <div class="relative">
        <div class="absolute h-25 border-l-2 border-dashed border-cement left-0 bottom-10" />
        <div class="absolute left-0 transform -translate-x-1/2 bottom-112 font-bold text-lg text-grey opacity-60">Poor</div>
        <div class="absolute h-25 border-l-2 border-dashed border-cement left-2/3 bottom-10" />
        <div class="absolute left-2/3 transform -translate-x-1/2 bottom-112 font-bold text-lg text-grey opacity-60">Good</div>
        <div class="absolute h-25 border-l-2 border-dashed border-cement right-0 bottom-10" />
        <div class="absolute right-0 transform translate-x-1/2 bottom-112 font-bold text-lg text-grey opacity-60">Ideal</div>
        <div class="absolute right-10 transform translate-x-1/2 top-32 font-bold text-lg text-grey">300dpi</div>
        <div class="border-b-10 border-green rounded-md" />
        <div class="w-10 h-10 bg-grey rounded-full absolute shadow-sm2 z-20" :style="meterStyle" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CropDigitalQualityMeter',
  props: {
    dpi: {
      type: Number,
      required: true,
    }
  },
  computed: {
    meterPercentage() {
      const dpiPercentage = this.dpi * 100 / 300
      return Math.min(dpiPercentage, 100)
    },
    meterStyle() {
      return {
        bottom: '100%',
        left: `${this.meterPercentage}%`,
        transform: 'translate(-50%, calc(50% + 5px))',
      }
    }
  }
}
</script>
