<template>
  <div>
    <v-p
      class="text-center"
      :body-size="1"
    >
      Failed to load basket...
    </v-p>
    <v-button
      class="mt-17 w-full"
      @click="$emit('tryAgain')"
    >
      Try again
    </v-button>
  </div>
</template>

<script>
import VP from '../Atoms/VP'
import VButton from '../Atoms/VButton'

export default {
  name: 'CartLoadingError',
  components: {
    VP,
    VButton,
  },
}
</script>
