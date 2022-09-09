<template>
  <div>
    <v-checkbox name="foil-blocking" v-model="chosen">
      <v-p :body-size="1" style="font-size: 20px; color: #1d2019">
        Personalised foil blocking
        <!-- <span v-if="foilBlockingAdditional.price > 0">
          (+£{{ foilBlockingAdditional.price }})
        </span> -->
        <div class="tooltip1">
          <img src="~images/tooltip.png" alt="tooltip1 icon" />
          <span class="tooltip1-text"
            >Add metallic text to your picture mount</span
          >
        </div>
      </v-p>
    </v-checkbox>
    <div v-if="chosen" class="mt-6">
      <v-input
        class="w-full"
        placeholder="Line 1"
        v-model="line1"
        :max-length="25"
      />
      <v-input
        v-if="isLine2Enabled"
        class="w-full mt-2"
        placeholder="Line 2"
        v-model="line2"
        :max-length="25"
      />
      <v-button
        v-if="isLine2Enabled"
        style-variant="ghost"
        class="mt-2"
        :padding-classes="['py-2']"
        @click="disableLine2"
      >
        Remove second line
      </v-button>
      <v-button
        v-else
        style-variant="ghost"
        class="mt-2"
        :padding-classes="['py-2']"
        @click="enableLine2"
      >
        Add second line
      </v-button>
      <v-dropdown
        title="Foil Blocking Color"
        v-model="color"
        :options="colorOptions"
      />
    </div>
  </div>
</template>

<script>
import VCheckbox from "../Atoms/VCheckbox";
import VInput from "../Atoms/VInput";
import VButton from "../Atoms/VButton";
import VP from "../Atoms/VP";
import VDropdown from "../Atoms/VDropdown";

export default {
  name: "ProductSectionFoilBlocking",
  components: {
    VCheckbox,
    VInput,
    VButton,
    VDropdown,
    VP,
  },
  props: {
    value: {
      type: Object,
      required: true,
    },
    availableFoilBlockingColors: {
      type: Array,
      required: true,
    },
    foilBlockingAdditional: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      isLine2Enabled: false,
      chosen: this.value.chosen,
      line1: this.value.line1,
      line2: this.value.line2,
      color: {
        label: this.value.color.name,
        value: this.value.color,
      },
    };
  },
  mounted () {
    const seperate = window.location.search.split("?");
    const localUrl = localStorage.getItem(seperate[1]);
    const parsedUrl = JSON.parse(localUrl);
      if (seperate[1]) {
        if(parsedUrl.foil_blocking.line2) {
          this.isLine2Enabled = true;
          this.line2 = parsedUrl.foil_blocking.line2;
        }
        this.color.value = parsedUrl.foil_blocking.color
        this.color.label= parsedUrl.foil_blocking.color.name
      }
  },
  watch: {
    chosen(newValue) {
      this.$emit("input", {
        chosen: newValue,
        line1: this.value.line1,
        line2: this.value.line2,
        color: this.value.color,
      });
    },
    line1(newValue) {
      this.$emit("input", {
        chosen: this.value.chosen,
        line1: newValue,
        line2: this.value.line2,
        color: this.value.color,
      });
    },
    line2(newValue) {
      this.$emit("input", {
        chosen: this.value.chosen,
        line1: this.value.line1,
        line2: newValue,
        color: this.value.color,
      });
    },
    color(newValue) {
      this.$emit("input", {
        chosen: this.value.chosen,
        line1: this.value.line1,
        line2: this.value.line2,
        color: newValue.value,
      });
    },
  },
  computed: {
    colorOptions() {
      return this.availableFoilBlockingColors.map((e) => ({
        label: e.name,
        value: e,
      }));
    },
  },
  methods: {
    enableLine2() {
      this.isLine2Enabled = true;
      this.line2 = undefined;
    },
    disableLine2() {
      this.isLine2Enabled = false;
      this.line2 = undefined;
    },
  },
};
</script>

<style>
.tooltip1 {
  top: 7px;
  position: relative;
  display: inline-block;
}

.tooltip1 .tooltip1-text {
  visibility: hidden;
  width: 267px;
  background-color: #f5f5f4;
  color: #1d2019;
  border-radius: 6px;
  position: absolute;
  z-index: 1;
  top: 100%;
  margin-left: -90px;
  padding: 10px;
  text-transform: initial;
  font-size: 14px;
  line-height: 20px;
  font-weight: 400;
}

.tooltip1:hover .tooltip1-text {
  visibility: visible;
}
</style>
