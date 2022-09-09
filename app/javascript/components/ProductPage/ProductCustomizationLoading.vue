<template>
  <v-p :body-size="1">
    Loading customization options...
  </v-p>
</template>

<script>
import VP from '../Atoms/VP'

export default {
  name: 'ProductCustomizationLoading',
  components: {
    VP,
  },
}
</script>
