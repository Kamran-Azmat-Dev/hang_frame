<template>
  <a
    class="block uppercase text-grey text-sm font-bold px-3 border-b border-grey20 py-4"
    :href="url"
  >
    {{ title }}
  </a>
</template>

<script>
export default {
  name: 'HamburgerMainItem',
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
