<template>
  <div class="w-full flex flex-col items-center upload-photo-step">
    <v-h3 v-if="isDigital" class="text-center">
      Upload your
      <span class="italic">digital photo</span>
    </v-h3>
    <span v-if="isDigital" class="text-center mt-3" style="font-size: 20px">
      We recommend printing photos that are at least 2MB.<br />
      See our
      <a
        style="margin-top: 2px"
        class="underline"
        href="https://www.hangframing.com/post/image-sizing-tips-for-digital-uploads"
        >Image sizing tips</a
      >
      for more information.
    </span>
    <v-h3 v-else class="text-center">
      Upload a picture of your
      <span class="italic">original art</span>
    </v-h3>
    <span v-if="!isDigital" class="my-1 w-full flex flex-col text-center">
      This preview image will help you visualise your artwork in the
      <br />different frame styles.
    </span>
    <div
      class="
        w-full
        max-w-475
        sm:max-w-90
        h-70
        sm:h-90
        bg-white
        mt-12
        mb-12
        md:mt-16 md:mb-16
        h-75
      "
    >
      <file-pond
        v-if="!isDigital"
        name="photo"
        ref="pond"
        label-idle="Drag and drop your photo here or <br> upload from your device"
        style-panel-layout="integrated"
        style-panel-aspect-ratio="1:1"
        :server="uploadPhotoPath"
        :allow-multiple="false"
        accepted-file-types="image/jpeg, image/png, image/heic, image/heif, image/tiff"
        max-file-size="30MB"
        image-validate-size-max-width="12000"
        image-validate-size-max-height="12000"
        :image-validate-size-measure="measureUnsupportedImage"
        credits="false"
        @addfilestart="uploadStarted"
        @processfilestart="uploadStarted"
        @processfile="uploadCompleted"
        @processfileabort="uploadError"
        @processfilerevert="uploadError"
      />
      <file-pond
        v-if="isDigital"
        name="photo"
        ref="pond"
        label-idle="Drop files here or click to <br>select photos"
        style-panel-layout="integrated"
        style-panel-aspect-ratio="1:1"
        :server="uploadPhotoPath"
        :allow-multiple="false"
        accepted-file-types="image/jpeg, image/png, image/heic, image/heif, image/tiff"
        max-file-size="30MB"
        image-validate-size-max-width="12000"
        image-validate-size-max-height="12000"
        :image-validate-size-measure="measureUnsupportedImage"
        credits="false"
        @addfilestart="uploadStarted"
        @processfilestart="uploadStarted"
        @processfile="uploadCompleted"
        @processfileabort="uploadError"
        @processfilerevert="uploadError"
      />
    </div>
    <v-button
      class="w-full max-w-77 flex flex-col items-center upload_btn"
      @click="nextStepClicked"
      :disabled="uploadInProgress || uploadProrcessingInProgress"
    >
      <div v-if="uploadProrcessingInProgress" class="flex mx-auto items-center">
        <img src="~images/loading.gif" class="w-4 h-4 mr-4" />
        <span>Processing...</span>
      </div>
      <span v-else-if="isUploadCompleted">Use this photo</span>
      <span v-else>Upload</span>
    </v-button>
    <v-p
      v-if="!isDigital"
      :body-size="1"
      style="letter-spacing: 2px;"
      class="
        text-center
        mt-4
        font-bold
        uppercase
        text-black1 text-sm
        leading-sm
        my-1
      "
    >
      NEED HELP?&nbsp;
      <a
        href="https://hangframing.com/how-it-works"
        style="text-decoration: underline; letter-spacing: 2px;"
        class="font-bold uppercase text-black1 text-sm leading-sm mt-4 my-1"
      >
        Step-by-step guide
      </a>
    </v-p>
  </div>
</template>

<script>
import VH3 from "../../Atoms/VH3";
import VButton from "../../Atoms/VButton";
import vueFilePond from "vue-filepond";
import { FileStatus } from "filepond";
import filePondPluginValidateType from "filepond-plugin-file-validate-type";
import filePondPluginValidateSize from "filepond-plugin-file-validate-size";
import filePondPluginImagePreview from "filepond-plugin-image-preview";
import filePondPluginImageValidateSize from "filepond-plugin-image-validate-size";
import "filepond/dist/filepond.min.css";
import "filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.css";
import { fetchUpload } from "../../../lib/api/upload";

const FilePond = vueFilePond(
  filePondPluginValidateType,
  filePondPluginValidateSize,
  filePondPluginImagePreview,
  filePondPluginImageValidateSize
);

export default {
  name: "UploadStepFile",
  components: {
    VH3,
    VButton,
    FilePond,
  },
  props: {
    uploadPhotoPath: {
      type: String,
      required: true,
    },
    routes: {
      type: Object,
      required: true,
    },
    isDigital: {
      type: Boolean,
      required: true,
    },
  },
  data() {
    return {
      uploadInProgress: false,
      uploadProrcessingInProgress: false,
      isUploadCompleted: false,
      checkStatusTimeout: undefined,
      measureUnsupportedImage: () => {
        return Promise.resolve({ width: 1000, height: 1000 });
      },
    };
  },
  destroyed() {
    if (this.checkStatusTimeout) {
      clearTimeout(this.checkStatusTimeout);
    }
  },
  methods: {
    uploadStarted() {
      this.uploadInProgress = true;
    },
    uploadCompleted() {
      this.uploadInProgress = false;
      this.uploadProrcessingInProgress = true;

      const checkStatusFunction = async () => {
        const pond = this.$refs.pond;
        const file = pond.getFile();
        if (!file || file.status !== FileStatus.PROCESSING_COMPLETE) {
          this.uploadProrcessingInProgress = false;
          return;
        }

        const parsedServerResponse = JSON.parse(file.serverId);
        const uploadUUID = parsedServerResponse.data.uuid;
        const result = await fetchUpload(
          this.routes.getPhotoPreviewPath,
          uploadUUID
        );

        if (result.status === "preview_ready") {
          this.uploadProrcessingInProgress = false;
          this.isUploadCompleted = true;

          if (this.checkStatusTimeout) {
            this.checkStatusTimeout = undefined;
          }
        } else {
          this.checkStatusTimeout = setTimeout(checkStatusFunction, 2000);
        }
      };

      this.checkStatusTimeout = setTimeout(checkStatusFunction, 2000);
    },
    uploadError() {
      this.uploadInProgress = false;
    },
    nextStepClicked() {
      const pond = this.$refs.pond;
      const file = pond.getFile();
      if (!file) {
        pond.browse();
      } else if (file.status === FileStatus.PROCESSING_COMPLETE) {
        const parsedServerResponse = JSON.parse(file.serverId);
        const uploadUUID = parsedServerResponse.data.uuid;
        this.$emit("uploadPhotoFinished", uploadUUID);
      }
    },
  },
};
</script>

<style>
.upload-photo-step .filepond--root {
  @apply font-display;
}

.upload-photo-step .filepond--panel-root {
  @apply bg-white;
}

.upload-photo-step .filepond--drop-label {
  @apply text-grey;
  font-size: 20px;
}

.upload-photo-step .filepond--image-preview {
  @apply bg-white;
}

.upload-photo-step .filepond--image-preview-overlay-success,
.upload-photo-step .filepond--image-preview-overlay-idle,
.upload-photo-step .filepond--file-status {
  @apply text-grey;
}

.upload-photo-step .filepond--file {
  @apply text-white;
}
@media all and (max-width: 540px) {
  .upload_btn {
    margin-top: 4rem !important;
  }
}
</style>
