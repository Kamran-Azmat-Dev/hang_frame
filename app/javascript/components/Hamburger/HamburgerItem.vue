<template>
  <a
    class="block text-grey px-3 py-2"
    :href="url"
  >
    {{ title }}
  </a>
</template>

<script>
export default {
  name: 'HamburgerItem',
  props: {
    title: {
      type: String,
      required: true,
    },
    url: {
      type: String,
      required: true,
    },
  },
}
</script>
