<template>
  <a
    class="block bg-neutral px-8 py-7 flex items-center"
    :href="url"
  >
    <img
      src="~images/profile.svg"
      class="w-6 h-6"
    />
    <div class="ml-4">
      {{ title }}
    </div>
  </a>
</template>

<script>
export default {
  name: 'HamburgerAccountLink',
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
