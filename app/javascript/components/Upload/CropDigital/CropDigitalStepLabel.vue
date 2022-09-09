<template>
  <div>
    <div
      class="
        rounded-full
        border border-grey
        w-10
        h-10
        text-center text-xl
        pt-1
        my-auto
        flex-shrink-0
      "
    >
      {{ number }}
    </div>
    <div class="ml-4 text-sl font-bold">
      {{ label }}
    </div>
  </div>
</template>

<script>
export default {
  name: "CropDigitalStepLabel",
  props: {
    number: {
      type: Number,
      required: true,
    },
    label: {
      type: String,
      required: true,
    },
  },
};
</script>
