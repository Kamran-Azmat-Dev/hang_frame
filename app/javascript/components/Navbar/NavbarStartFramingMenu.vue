<template>
  <div class="flex bg-white w-196 shadow-md z-40">
    <navbar-start-framing-item
      title="Browse all frames"
      :url="routes.allProductsPath"
      image="navbar-all-frames"
      class="border-r border-grey20 border-dashed"
    />
    <navbar-start-framing-item
      title="Custom Frame Digital Uploads"
      @click.native="uploadPath()"
      image="navbar-upload-digital"
      class="border-r border-grey20 border-dashed"
    />
    <navbar-start-framing-item
      title="Frame an artwork"
      :url="routes.originalArtUploadPath"
      image="navbar-upload-original-art"
      class="border-r border-grey20 border-dashed"
    />
    <navbar-start-framing-item
      title="Shop standard/gift frames"
      href="/t/standard"
      image="navbar-go-to-standard"
    />
  </div>
</template>

<script>
import NavbarStartFramingItem from './NavbarStartFramingItem'

export default {
  name: 'NavbarStartFramingMenu',
  components: {
    NavbarStartFramingItem,
  },
  props: {
    routes: {
      type: Object,
      required: true,
    },
  },
  methods: {
    uploadPath() {
      window.location = `${this.routes.digitalUploadPath}?upload_type=custom`
    }
  }
}
</script>
