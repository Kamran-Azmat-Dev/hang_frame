<template>
  <div
    v-if="!item.isPickup && !item.isDonation && !item.isWrapped"
    class="grid grid-cols-4 gap-6"
  >
    <div class="flex flex-col items-center w-full">
      <custom-frame-preview
        v-if="item.isCustom"
        class="object-contain max-h-40"
        :namespace="`${item.id}`"
        :upload="item.hangPhoto"
        :mount-dimensions="item.mountDimensions"
        :foil-blocking-options="item.additionals.foilBlocking"
        :configuration="customPreviewConfiguration"
      />
      <standard-frame-preview
        v-else
        class="object-contain max-h-40"
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
    <div class="col-span-3 flex">
      <div>
        <v-p :body-size="1">
          {{ item.name }}
        </v-p>
        <v-p class="text-grey2" :body-size="1">
          {{ typeLabel }}
        </v-p>
        <div class="flex">
          <v-button
            style-variant="ghost"
            class="mt-3"
            :padding-classes="[]"
            @click="$emit('edit')"
          >
            Edit
          </v-button>
          <v-button
            style-variant="ghost"
            class="mt-3 ml-4"
            :padding-classes="[]"
            @click="$emit('remove')"
          >
            Remove
          </v-button>
          <v-button
            v-if="item.isCustom"
            style-variant="ghost"
            class="mt-3 ml-4"
            :padding-classes="[]"
            @click="$emit('duplicate')"
          >
            Duplicate
          </v-button>
        </div>
      </div>
      <v-p class="ml-auto mr-0 font-bold" :body-size="1">
        {{ item.displayTotal }}
      </v-p>
    </div>
  </div>
</template>

<script>
import VP from "../../Atoms/VP";
import VButton from "../../Atoms/VButton";
import StandardFramePreview from "../../Preview/StandardFramePreview";
import CustomFramePreview from "../../Preview/CustomFramePreview";

export default {
  name: "CartPageItem",
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
    cart: {
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
        padding: 1,
        enableShadows: false,
      };

      if (this.item.accentMountColor) {
        result.accentMount = this.item.accentMountColor.regular;
      }

      return result;
    },
    typeLabel() {
      const frameType =
        this.item.hangPhoto && this.item.hangPhoto.uploadType === "standard"
          ? "Standard"
          : "Custom";
      const artType =
        this.item.hangPhoto && this.item.hangPhoto.uploadType === "original"
          ? "Original Art"
          : "Digital";
      return `${frameType} - ${artType}`;
    },
  },
};
</script>
