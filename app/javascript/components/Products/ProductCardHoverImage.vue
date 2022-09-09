<template>
  <transition name="fade">
    <img class="absolute h-81" v-show="isVisible" :src="hoverImageUrl" />
  </transition>
</template>

<script>
export default {
  props: {
    hoverImageUrl: {
      type: String,
      required: true
    },
    isVisible: {
      type: Boolean,
      required: true
    }
  }
};
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity 500ms;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>
