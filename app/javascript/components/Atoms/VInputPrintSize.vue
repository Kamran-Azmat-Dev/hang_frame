<template>
<div class="input-wrapper">
  <input
    class="md:text-lg md:leading-lg border text-grey rounded-sm focus:outline-none focus:border-grey disabled:text-grey50"
    :class="classes"
    :value="value"
    :placeholder="placeholder"
    :maxlength="maxLength"
    @input="$emit('input', $event.target.value)"
    @blur="$emit('blur', $event.target.value)"
  />
  <div v-if="title" class="tracking-wide text-sm leading-base text-grey2 uppercase font-bold input-title">
    {{ title }}
  </div>
</div>
</template>

<script>
export default {
  name: 'VInput',
  props: {
    value: {
      type: String,
      default: '',
    },
    placeholder: {
      type: String,
      default: undefined,
    },
    maxLength: {
      type: Number,
      default: undefined,
    },
    title: {
      type: String,
      default: undefined,
    },
    color: {
      type: String,
      default: 'white',
    },
    paddingClasses: {
      type: Array,
      default() {
        return ['px-4', 'py-3']
      }
    },
  },
  computed: {
    classes() {
      let classes = []
      if (this.color === 'white') {
        classes.push('border-grey50')
      } else if (this.color === 'grey') {
        classes.push('border-cement')
      }

      return [...this.paddingClasses, classes]
    }
  }
}
</script>

<style>
.input-wrapper {
  position: relative;
}

.input-wrapper input {
  max-width: 100%;
  padding-top: 36px;
}


.input-wrapper .input-title {
  position: absolute;
  left: 16px;
  top: 12px;
}
</style>