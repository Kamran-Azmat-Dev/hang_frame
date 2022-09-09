<template>
  <img
    class="v-arrow-down"
    src="~images/arrow-down.svg"
    @click="$emit('click')"
  />
</template>

<script>
export default {
  name: 'VArrowDown',
}
</script>

<style scoped>
.v-arrow-down {
  width: 22px;
  height: 7px;
}
</style>
