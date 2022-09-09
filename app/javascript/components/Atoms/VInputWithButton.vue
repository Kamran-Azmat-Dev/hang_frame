<template>
  <div
    class="flex border rounded-sm v-input-with-button"
    :class="containerClasses"
  >
    <input
      class="md:text-lg md:leading-lg bg-transparent focus:outline-none w-full px-4 py-3"
      :class="inputClasses"
      :value="value"
      :placeholder="placeholder"
      :name="name"
      @input="$emit('input', $event.target.value)"
      @blur="$emit('blur', $event.target.value)"
    />
    <button
      class="flex-shrink-0 tracking-wide text-sm leading-lg font-bold uppercase focus:outline-none px-4 py-3 ml-auto mr-0 hover:underline"
      @click="$emit('buttonClick')"
    >
      {{ buttonLabel }}
    </button>
  </div>
</template>

<style scoped>
.v-input-with-button.v-input-with-button--dark input::placeholder {
  @apply text-neutral;
}
</style>

<script>
export default {
  name: 'VInputWithButton',
  props: {
    placeholder: {
      type: String,
      default: '',
    },
    buttonLabel: {
      type: String,
      required: true,
    },
    color: {
      type: String,
      default: 'white',
    },
    name: {
      type: String,
      default: undefined,
    },
    value: {
      type: String,
      required: true,
    }
  },
  computed: {
    containerClasses() {
      if (this.color === 'dark') {
        return ['v-input-with-button--dark', 'border-white']
      }
      return ['border-grey50']
    },
    inputClasses() {
      if (this.color === 'dark') {
        return ['text-white']
      }
      return []
    },
    buttonClasses() {
      if (this.color === 'dark') {
        return ['text-neutral']
      }

      return []
    },
  }
}
</script>
