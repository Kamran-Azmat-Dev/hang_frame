<template>
  <div>
    <v-p
      v-if="!isMatchingDpiForSmallestPrintSize"
      :body-size="1"
      class="text-center text-red"
    >
      Your image is too small to print and could be a thumbnail.
    </v-p>
    <v-p 
      v-else
      :body-size="1"
      class="text-center text-red"
    >
      Oops, it looks like your photo is too small for this size print. Upload a bigger version, or choose a smaller print size.
    </v-p>
    <v-p
      :body-size="1"
      class="text-center"
    >
      We can help. See our <a class="underline" href="https://www.hangframing.com/post/image-sizing-tips-for-digital-uploads">image sizing tips.</a>
    </v-p>
  </div>
</template>

<script>
import VP from '../../Atoms/VP'

export default {
  name: 'CropDigitalDpiError',
  components: {
    VP,
  },
  props: {
    isMatchingDpiForSmallestPrintSize: {
      type: Boolean,
      default: false
    }
  }
}
</script>
