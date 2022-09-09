<template>
  <div
    v-if="!item.isPickup && !item.isDonation && !item.isWrapped"
    class="flex items-center"
  >
    <div class="w-28 h-28">
      <custom-frame-preview
        v-if="item.isCustom"
        class="w-28 h-28"
        :namespace="`${item.id}`"
        :upload="item.hangPhoto"
        :mount-dimensions="item.mountDimensions"
        :foil-blocking-options="item.additionals.foilBlocking"
        :configuration="customPreviewConfiguration"
      />
      <standard-frame-preview
        v-else
        class="w-28 h-28"
        :frame-photo-url="item.image.framePhotoUrl"
        :frame-photo-width="item.image.framePhotoWidth"
        :frame-photo-height="item.image.framePhotoHeight"
        :frame-preview-x="item.image.framePreviewX"
        :frame-preview-y="item.image.framePreviewY"
        :frame-preview-width="item.image.framePreviewWidth"
        :frame-preview-height="item.image.framePreviewHeight"
        :upload="item.hangPhoto"
      />
    </div>
    <div class="ml-4">
      <v-p :body-size="1">
        {{ item.name }}
      </v-p>
      <v-p :body-size="3">
        {{ item.displayTotal }}
      </v-p>
      <div class="flex">
        <v-button
          style-variant="ghost"
          class="mt-4"
          :padding-classes="[]"
          @click="$emit('remove')"
        >
          Remove
        </v-button>
        <!-- <v-button
          v-if="item.isCustom"
          style-variant="ghost"
          class="mt-4 ml-4"
          :padding-classes="[]"
          @click="$emit('duplicate')"
        >
          Duplicate
        </v-button> -->
      </div>
    </div>
  </div>
</template>

<script>
import VP from "../../Atoms/VP";
import VButton from "../../Atoms/VButton";
import StandardFramePreview from "../../Preview/StandardFramePreview";
import CustomFramePreview from "../../Preview/CustomFramePreview";

export default {
  name: "CartDrawerItem",
  components: {
    VP,
    VButton,
    StandardFramePreview,
    CustomFramePreview,
  },
  props: {
    item: {
      type: Object,
      required: true,
    },
  },
  computed: {
    customPreviewConfiguration() {
      const result = {
        ...this.item.mountColor.regular,
        ...this.item.framePreviewImages.find(
          (e) => e.name === "border_pattern"
        ),
        enableShadows: false,
      };

      if (this.item.accentMountColor) {
        result.accentMount = this.item.accentMountColor.regular;
      }

      return result;
    },
  },
};
</script>
