<template>
  <div 
    class="flex flex-col items-center text-center bg-white rounded-sm transition-all duration-200 pt-12 md:pt-19 pb-12 md:pb-17" 
    :class="classes"
    @mouseover="selectOption"
    @mouseleave="$emit('resetSelectedOption')"
  >
    <v-h4 class="mb-5">{{ option.label }}</v-h4>
    <v-p class="my-1" v-for="(detail, index) in option.details" :key="index" :body-size="2">{{ detail }}</v-p>
    <v-button
      class="w-full max-w-77 transition-all duration-200 mt-5"
      :style-variant="buttonVariant"
      @click="$emit('uploadTypeSelected', option.id)"
    >
      Let's get framing
    </v-button>
  </div>
</template>

<script>
import VH4 from '../../Atoms/VH4'
import VP from '../../Atoms/VP'
import VButton from '../../Atoms/VButton'

export default {
  name: 'TypeOption',
  components: {
    VH4,
    VP,
    VButton
  },
  props: {
    option: {
      type: Object,
      required: true,
    },
    selected: {
      type: Boolean,
      required: true,
    }
  },
  computed: {
    classes() {
      if (this.selected) {
        return ['shadow-md'];
      } else {
        return []
      }
    },
    buttonVariant() {
      return 'outline'
    }
  },
  methods: {
    selectOption() {
      if (!this.selected) this.$emit('selectOption', this.option);
    },
  }
}
</script>
