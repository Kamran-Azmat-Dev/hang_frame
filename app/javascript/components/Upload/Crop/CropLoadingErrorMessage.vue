<template>
  <div>
    <v-p
      :body-size="1"
      class="mt-6 text-center"
    >
      Failed to load photo...
    </v-p>
  </div>
</template>

<script>
import VP from '../../Atoms/VP'

export default {
  name: 'CropLoadingErrorMessage',
  components: {
    VP,
  },
}
</script>
