<template>
  <div class="flex items-center">
    <div class="pr-4">
      <div v-if="price" class="text-3xl">&#163;{{ formattedPrice }}</div>
      <div v-else class="text-xl">Not available</div>
    </div>
    <v-button
      class="ml-auto w-full max-w-77 flex"
      :disabled="isCartAddInProgress || !isProductAvailable"
      @click="addToCart"
    >
      <div v-if="isCartAddError" class="flex items-center mx-auto">
        Could not add to basket
      </div>
      <div v-else-if="isCartAddInProgress" class="flex items-center mx-auto">
        Adding...
      </div>
      <div v-else class="flex items-center mx-auto">
        <img src="~images/cart.svg" />
        <div class="ml-4">Add to basket</div>
      </div>
    </v-button>
  </div>
</template>

<script>
import VButton from "../Atoms/VButton";
import { addItem } from "../../lib/api/cart";

export default {
  name: "ProductCartButton",
  components: {
    VButton,
  },
  props: {
    variant: {
      type: Object,
      required: true,
    },
    price: {
      type: Number,
      default: undefined,
    },
    uploadUuid: {
      type: String,
      required: true,
    },
    isCustomFrame: {
      type: Boolean,
      required: true,
    },
    printSizeId: {
      type: Number,
      default: undefined,
    },
    mountColor: {
      type: Object,
      default: undefined,
    },
    accentMountColor: {
      type: Object,
      default: undefined,
    },
    mountType: {
      type: Object,
      default: undefined,
    },
    mountOption: {
      type: Object,
      default: undefined,
    },
    foilBlockingOptions: {
      type: Object,
      default: undefined,
    },
    foilBlockingAdditional: {
      type: Object,
      default: undefined,
    },
    linenChosen: {
      type: Boolean,
      default: false,
    },
    linenAdditional: {
      type: Object,
      default: undefined,
    },
    mountDimensions: {
      type: Object,
      default: undefined,
    },
    routes: {
      type: Object,
      required: true,
    },
    isProductAvailable: {
      type: Boolean,
      required: true,
    },
    product: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      isCartAddInProgress: false,
      isCartAddError: false,
    };
  },
  computed: {
    formattedPrice() {
      if (!this.price) {
        return "";
      }

      return parseFloat(this.price).toFixed(2);
    },
  },
  methods: {
    async addToCart() {
      // const localId = Math.floor(1000 + Math.random() * 9000);
      
      if (this.isCartAddInProgress || !this.price) {
        return;
      }

      this.isCartAddInProgress = true;
      this.isCartAddError = false;

      try {
        let payloadOptions = {
          hang_photo_uuid: this.uploadUuid,
        };

        if (this.isCustomFrame) {
          payloadOptions = {
            ...payloadOptions,
            print_size_id: this.printSizeId,
            mount_type_id: this.mountType.id,
            mount_option_id: this.mountOption.id,
            mount_dimensions: {
              top: this.mountDimensions.top,
              left: this.mountDimensions.left,
              bottom: this.mountDimensions.bottom,
              right: this.mountDimensions.right,
            },
            mount_color_id: this.mountColor.id,
          };

          if (
            this.foilBlockingOptions &&
            this.foilBlockingAdditional &&
            this.foilBlockingOptions.chosen
          ) {
            payloadOptions = {
              ...payloadOptions,
              foil_blocking: {
                additional_id: this.foilBlockingAdditional.id,
                line1: this.foilBlockingOptions.line1,
                line2: this.foilBlockingOptions.line2,
                color: this.foilBlockingOptions.color,
              },
            };
          }

          if (this.linenChosen) {
            payloadOptions = {
              ...payloadOptions,
              additionals: [this.linenAdditional.id],
            };
          }

          if (this.accentMountColor) {
            payloadOptions = {
              ...payloadOptions,
              accent_mount_color_id: this.accentMountColor.id,
            };
          }
        } else {
          if (
            this.foilBlockingOptions &&
            this.foilBlockingAdditional &&
            this.foilBlockingOptions.chosen
          ) {
            payloadOptions = {
              ...payloadOptions,
              foil_blocking: {
                additional_id: this.foilBlockingAdditional.id,
                line1: this.foilBlockingOptions.line1,
                line2: this.foilBlockingOptions.line2,
                color: this.foilBlockingOptions.color,
              },
            };
          }
        }
         await addItem(this.routes, this.variant.variantId, payloadOptions);
    
        
        this.$sharedEventBus.$emit("showCartDrawer");
      } catch (e) {
        this.isCartAddError = true;
        console.error(e);
      } finally {
        this.isCartAddInProgress = false;
      }
    },
  },
};
</script>
