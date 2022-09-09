<template>
  <div class="v-checkbox-container">
    <input
      :id="name"
      type="checkbox"
      class="v-checkbox-input"
      :checked="value"
      :name="name"
      :required="required"
      @input="$emit('input', $event.target.checked)"
    >
    <label class="v-checkbox-label flex items-end select-none" :for="name">
      <slot />
    </label>
  </div>
</template>

<script>
export default {
  name: 'VCheckbox',
  props: {
    name: {
      type: String,
      required: true,
    },
    value: {
      type: Boolean,
      default: false,
    },
    required: {
      type: Boolean,
      default: false,
    },
  },
}
</script>

<style scoped>
.v-checkbox-container {
  @apply relative;
}
.v-checkbox-input {
  @apply cursor-pointer;
    opacity: 0;
    position: absolute;
    width: 1.2rem;
    height: 1.2rem;
}
.v-checkbox-label {
  @apply flex;
  @apply cursor-pointer;
}
.v-checkbox-input ~ .v-checkbox-label:before {
  @apply text-2xl;
  content: ' ';
}
.v-checkbox-input:checked ~ .v-checkbox-label:before {
  background-image: url(~images/checkbox-check.svg);
  background-size: 80%;
  @apply bg-center;
  @apply bg-no-repeat;
}
.v-checkbox-input:focus ~ .v-checkbox-label:before {
  @apply text-grey;
  @apply border-grey50;
}
.v-checkbox-label:before {
  @apply text-grey;
  @apply border-grey50;
  @apply border;
  @apply rounded-sm;
  @apply inline-block;
  @apply h-8;
  @apply w-8;
  @apply mr-3;
  @apply mt-1;
  @apply flex-grow-0;
  @apply flex-shrink-0;
  @apply text-center;
  @apply leading-base;
}
</style>
