<template>
  <div>
    <v-p
      class="text-center"
      :body-size="1"
    >
      Your basket is empty
    </v-p>
    <v-button
      class="mt-17 w-full px-16"
      @click="shopAllFrames"
    >
      Shop all frames
    </v-button>
  </div>
</template>

<script>
import VP from '../Atoms/VP'
import VButton from '../Atoms/VButton'

export default {
  name: 'CartEmptyContent',
  components: {
    VP,
    VButton,
  },
  props: {
    allProductsPath: {
      type: String,
      required: true,
    },
  },
  methods: {
    shopAllFrames() {
      window.location = this.allProductsPath
    }
  }
}
</script>
