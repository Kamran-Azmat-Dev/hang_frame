<template>
  <div>
    <slot
      :upload="upload"
      :upload-uuid="uploadUuid"
    />
  </div>
</template>

<script>
import { fetchUpload } from '../../lib/api/upload'

export default {
  name: 'LoadUploadPreview',
  props: {
    getPhotoPreviewPath: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      uploadUuid: this.$cookies.get('uploadUUID'),
      isUploadLoading: true,
      upload: undefined,
    }
  },
  async mounted() {
    if (!this.uploadUuid) {
      this.isUploadLoading = false
      return
    }

    try {
      this.upload = await fetchUpload(this.getPhotoPreviewPath, this.uploadUuid)
    } finally {
      // For errors, just leave blank preview image url
      this.isUploadLoading = false
    }
  }
}
</script>
