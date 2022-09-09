<template>
  <div class="flex">
    <img
      src="~images/close-hamburger-menu.svg"
      class="w-10 h-10 flex-shrink-0 cursor-pointer"
      @click="$emit('closeHamburgerMenu')"
    />
  </div>
</template>

<script>
export default {
  name: 'HamburgerHeader',
}
</script>
