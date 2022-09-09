<template>
  <div>
    <hamburger-main-item
      title="Browse all frames"
      :url="routes.allProductsPath"
    />
    <hamburger-main-item
      title="Custom Frame digital uploads"
      @click.native="uploadPath()"
    />
    <hamburger-main-item
      title="Frame an artwork"
      :url="routes.originalArtUploadPath"
    />
    <hamburger-main-item title="Shop standard/gift frames" href="/t/standard" />
  </div>
</template>

<script>
import HamburgerMainItem from "./HamburgerMainItem";

export default {
  name: "HamburgerMainItems",
  components: {
    HamburgerMainItem,
  },
  props: {
    routes: {
      type: Object,
    },
  },
  methods: {
    uploadPath() {
      window.location = `${this.routes.digitalUploadPath}?upload_type=custom`;
    },
  },
};
</script>
