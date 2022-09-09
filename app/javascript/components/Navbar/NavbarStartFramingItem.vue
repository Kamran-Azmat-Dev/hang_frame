<template>
  <a
    class="block w-64 flex flex-col items-center hover:bg-neutral pt-6 pb-10"
    :href="url"
  >
    <img class="w-26 h-26 pointer-events-none" :src="imageUrl" />
    <v-p class="mt-4" :body-size="2">
      {{ title }}
    </v-p>
  </a>
</template>

<script>
import VP from "../Atoms/VP";

export default {
  name: "NavbarStartFramingItem",
  components: {
    VP,
  },
  props: {
    title: {
      type: String,
      required: true,
    },
    image: {
      type: String,
      required: true,
    },
    url: {
      type: String,
      required: true,
    },
  },
  computed: {
    imageUrl() {
      return require(`../../images/${this.image}.png`);
    },
  },
};
</script>
