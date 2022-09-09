<template>
  <vue-select
    class="v-dropdown"
    :class="`v-dropdown--${color}`"
    transition=""
    :clearable="false"
    :searchable="false"
    :options="options"
    :value="value"
    @input="newValue => $emit('input', newValue)"
  >
    <template #open-indicator="{ attributes }">
      <span v-bind="attributes">
        <v-arrow-down />
      </span>
    </template>

    <template #option="{ label }">
      <div class="px-3 py-2 text-lg leading-xl font-bold">{{ label }}</div>
    </template>

    <template #selected-option="{ label }">
      <div class="flex flex-col">
        <div v-if="title" class="tracking-wide text-sm leading-base text-grey2 uppercase font-bold">{{ title }}</div>
        <div class="text-lg leading-xl font-bold">{{ label }}</div>
      </div>
    </template>
  </vue-select>
</template>

<script>
import VueSelect from 'vue-select'
import VArrowDown from './VArrowDown'
import 'vue-select/dist/vue-select.css'

export default {
  name: 'VDropdown',
  components: {
    VueSelect,
    VArrowDown,
  },
  props: {
    title: {
      type: String,
      default: undefined,
    },
    options: {
      type: Array,
      required: true,
    },
    value: {
      type: Object,
      default: undefined,
    },
    color: {
      type: String,
      default: 'white',
    },
  },
}
</script>

<style>
.v-dropdown.v-select {
  @apply text-grey;
}

.v-dropdown--white.v-select {
  @apply bg-white;
}

.vdropdown--grey.v-select {
  @apply bg-neutral;
}

.v-dropdown.v-select .vs__dropdown-toggle {
  @apply px-6;
  @apply py-3;
}

.v-dropdown.v-select--white .vs__dropdown-toggle {
  @apply border-grey;
}

.v-dropdown.v-select--grey .vs__dropdown-toggle {
  @apply border-cement;
}

.v-dropdown.v-select .vs__dropdown-option--highlight {
  @apply bg-grey;
  @apply text-white;
}

.v-dropdown.v-select.vs--open .vs__selected {
  @apply relative;
}
</style>
