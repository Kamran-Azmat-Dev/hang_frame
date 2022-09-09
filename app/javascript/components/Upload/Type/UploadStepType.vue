<template>
  <div class="w-full flex flex-col items-center">
    <v-h3 class="text-center">
      What are you custom
      <span style="font-style: italic">framing?</span>
    </v-h3>
    <!-- <v-p
      :body-size="1"
      class="text-center mt-6"
    >
      We recommend printing photos that are at least 2MB. <br class="hidden md:inline" />
      See our <a class="underline" href="https://www.hangframing.com/post/image-sizing-tips-for-digital-uploads">Image sizing tips</a> for more information.
    </v-p> -->
    <div
      class="
        mt-12
        md:mt-15
        mb-8
        md:mb-19
        grid
        md:grid-cols-2
        gap-6
        md:gap-10
        w-full
        max-w-360
        h-380
      "
    >
      <!-- <div class="mt-12 md:mt-15 mb-8 md:mb-19 w-full max-w-190"> -->
      <type-option
        :option="uploadTypeOptions.standard"
        :selected="isSelected(uploadTypeOptions.standard)"
        @selectOption="selectOption"
        @resetSelectedOption="resetSelectedOption"
        @uploadTypeSelected="uploadTypeSelected"
      />
      <type-option
        :option="uploadTypeOptions.custom"
        :selected="isSelected(uploadTypeOptions.custom)"
        @selectOption="selectOption"
        @resetSelectedOption="resetSelectedOption"
        @uploadTypeSelected="uploadTypeSelected"
      />
    </div>
  </div>
</template>

<script>
import VButton from "../../Atoms/VButton";
import VP from "../../Atoms/VP";
import VH3 from "../../Atoms/VH3";
import TypeOption from "./TypeOption";
import { digitalUploadTypes } from "../constants";

export default {
  name: "UploadStepType",
  components: {
    VButton,
    VP,
    VH3,
    TypeOption,
  },
  data() {
    return {
      selectedOptionId: undefined,
    };
  },
  computed: {
    uploadTypeOptions() {
      return digitalUploadTypes;
    },
  },
  methods: {
    selectOption(option) {
      this.selectedOptionId = option.id;
    },
    resetSelectedOption() {
      this.selectedOptionId = undefined;
    },
    isSelected(option) {
      return option.id === this.selectedOptionId;
    },
    uploadTypeSelected(optionId) {
      this.$emit("uploadTypeSelected", optionId);
    },
  },
};
</script>
