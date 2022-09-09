<template>
  <div>
    <v-p
      class="text-center"
      :body-size="1"
    >
      Loading basket...
    </v-p>
  </div>
</template>

<script>
import VP from '../Atoms/VP'

export default {
  name: 'CartLoading',
  components: {
    VP,
  },
}
</script>
