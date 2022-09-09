<template>
  <div class="grid grid-cols-12 gap-4">
    <div class="col-span-7">
      <v-small-heading class="text-grey2">
        Change the width of the mount (cm)
      </v-small-heading>
      <v-p :body-size="3" class="mt-4">
        These are standardised for a {{ formattedWidth }}x{{
          formattedHeight
        }}cm print.
      </v-p>
    </div>
    <div class="col-span-5 grid grid-cols-3 gap-3 items-center">
      <v-input
        class="text-center"
        :padding-classes="['px-1', 'py-1']"
        :disabled="!enabled"
        :value="leftString"
        @blur="(value) => onLeftChanged(value)"
      />
      <div class="flex flex-col">
        <v-input
          class="text-center mb-3"
          :padding-classes="['px-1', 'py-1']"
          :disabled="!enabled"
          :value="topString"
          @blur="(value) => onTopChanged(value)"
        />
        <v-input
          class="text-center"
          :padding-classes="['px-1', 'py-1']"
          :disabled="!enabled"
          :value="bottomString"
          @blur="(value) => onBottomChanged(value)"
        />
      </div>
      <v-input
        class="text-center"
        :padding-classes="['px-1', 'py-1']"
        :disabled="!enabled"
        :value="rightString"
        @blur="(value) => onRightChanged(value)"
      />
    </div>
  </div>
</template>

<script>
import VP from "../Atoms/VP";
import VSmallHeading from "../Atoms/VSmallHeading";
import VInput from "../Atoms/VInput";
import { formatFrameDimension } from "../../display";

const numericValue = (value) => {
  return parseFloat(value) || 0;
};

export default {
  name: "ProductSectionMountDimensions",
  components: {
    VP,
    VSmallHeading,
    VInput,
  },
  props: {
    value: {
      type: Object,
      required: true,
    },
    localMountDimensions: {
      type: Object,
      required: false,
    },
    enabled: {
      type: Boolean,
      default: true,
    },
    printSize: {
      type: Object,
      required: true,
    },
    minimumMountDimensions: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      left: this.value.left.toFixed(1),
      right: this.value.right.toFixed(1),
      top: this.value.top.toFixed(1),
      bottom: this.value.bottom.toFixed(1),
    };
  },
  computed: {
    formattedWidth() {
      return formatFrameDimension(this.printSize.width);
    },
    formattedHeight() {
      return formatFrameDimension(this.printSize.height);
    },

    leftString() {
      if (this.localMountDimensions) {
        return this.localMountDimensions.left.toString();
      } else {
        return this.value.left.toString();
      }
    },
    rightString() {
      if (this.localMountDimensions) {
        return this.localMountDimensions.right.toString();
      } else {
        return this.value.right.toString();
      }
    },
    topString() {
      if (this.localMountDimensions) {
        return this.localMountDimensions.top.toString();
      } else {
        return this.value.top.toString();
      }
    },
    bottomString() {
      if (this.localMountDimensions) {
        return this.localMountDimensions.bottom.toString();
      } else {
        return this.value.bottom.toString();
      }
      
    },
  },
  mounted () {
    this.localDimensionChanged(this.localMountDimensions.left, this.localMountDimensions.right, this.localMountDimensions.top, this.localMountDimensions.bottom)
  },
  methods: {
    onLeftChanged(newValue) {
      const valueToEmit = Math.max(
        numericValue(this.minimumMountDimensions.left),
        numericValue(newValue)
      );

      this.$emit("input", {
        left: valueToEmit,
        right: numericValue(this.value.right),
        top: numericValue(this.value.top),
        bottom: numericValue(this.value.bottom),
      });
    },
    localDimensionChanged(left, right, top, bottom) {
      const leftEmit = Math.max(
        numericValue(this.minimumMountDimensions.left),
        numericValue(left)
      );
      const rightEmit = Math.max(
        numericValue(this.minimumMountDimensions.right),
        numericValue(right)
      );
      const topEmit = Math.max(
        numericValue(this.minimumMountDimensions.top),
        numericValue(top)
      );
      const bottomEmit = Math.max(
        numericValue(this.minimumMountDimensions.bottom),
        numericValue(bottom)
      );

      this.$emit("input", {
        left: leftEmit,
        right: rightEmit,
        top: topEmit,
        bottom: bottomEmit,
      });
    },
    onRightChanged(newValue) {
      const valueToEmit = Math.max(
        numericValue(this.minimumMountDimensions.right),
        numericValue(newValue)
      );

      this.$emit("input", {
        left: numericValue(this.value.left),
        right: valueToEmit,
        top: numericValue(this.value.top),
        bottom: numericValue(this.value.bottom),
      });
    },
    onTopChanged(newValue) {
      const valueToEmit = Math.max(
        numericValue(this.minimumMountDimensions.top),
        numericValue(newValue)
      );

      this.$emit("input", {
        left: numericValue(this.value.left),
        right: numericValue(this.value.right),
        top: valueToEmit,
        bottom: numericValue(this.value.bottom),
      });
    },
    onBottomChanged(newValue) {
      const valueToEmit = Math.max(
        numericValue(this.minimumMountDimensions.bottom),
        numericValue(newValue)
      );

      this.$emit("input", {
        left: numericValue(this.value.left),
        right: numericValue(this.value.right),
        top: numericValue(this.value.top),
        bottom: valueToEmit,
      });
    },
  },

};
</script>
