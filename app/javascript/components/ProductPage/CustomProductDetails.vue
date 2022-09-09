<template>
  <div class="flex flex-col md:flex-row">
    <div class="w-full">
      <div class="w-full md:ml-auto md:mr-0 md:max-w-xl-1/2 top-96">
        <product-image-carousel
          v-if="shouldShowImageCarousel"
          class="mt-4 mb-4 md:mt-7"
          :product="product"
          :variant="variant"
          :mount-color="mountColor"
          :current-image="currentImage"
          :mount-dimensions="mountDimensions"
          :upload="upload"
          @change="(e) => changeCurrentImage(e)"
        />
      </div>
      <div class="w-full md:ml-auto md:mr-0 md:max-w-xl-1/2 md:sticky top-96">
        <div class="md:ml-auto md:mr-0 px-6 md:pl-6 md:pr-0">
          <frame-image-preview v-if="currentImage" :image="currentImage" />
          <custom-frame-preview
            v-else
            class="md:h-80vh w-full"
            :mount-dimensions="mountDimensions"
            :upload="upload"
            :foil-blocking-options="foilBlockingOptions"
            :configuration="framePreviewConfiguration"
            namespace="main-preview"
          />
        </div>
      </div>
    </div>
    <div class="w-full bg-white">
      <div v-if="product.isCustom">
        <a
          style="font-size: 14px"
          class="
            block
            ml-5
            mt-9
            tracking-wide
            leading-lg
            font-bold
            uppercase
            focus:outline-none
            hover:underline
            text-grey
          "
          href="/t/custom"
        >
          &lt; Back to frames
        </a>
      </div>
      <div v-else>
        <a
          style="font-size: 14px"
          class="
            block
            ml-5
            mt-9
            tracking-wide
            leading-lg
            font-bold
            uppercase
            focus:outline-none
            hover:underline
            text-grey
          "
          href="/t/standard"
        >
          &lt; Back to frames
        </a>
      </div>
      <div class="w-full md:ml-0 md:mr-auto md:max-w-xl-1/2">
        <div class="md:ml-0 md:mr-auto px-6 md:pl-0 md:pl-6">
          <div class="xl:pl-30 pb-25">
            <v-h3 class="text-center mt-10 md:mt-20">
              {{ product.name }}
            </v-h3>
            <v-p class="text-center" :body-size="2">
              {{ product.shortDescription }}
            </v-p>

            <product-chevron-carousel
              v-if="chevrons && product.isCustom"
              class="mt-10"
              :chevrons="chevrons"
              :initial-product-slug="product.slug"
              @change="(e) => switchCustomFrame(e.productSlug)"
            />
            <product-chevron-carousel
              v-if="
                (chevrons &&
                  product.isPersonalizedStandard &&
                  chevrons.length > 1) ||
                !product.isCustom
              "
              class="mt-10"
              :chevrons="chevrons"
              :initial-product-slug="product.slug"
              @change="(e) => switchStandardFrame(e.productSlug)"
            />
            <v-hr class="my-8" />
            <div v-if="product.isCustom || product.isPersonalizedStandard">
              <product-section-art-type
                v-if="upload"
                class="my-6 md:pl-8"
                :upload="upload"
                :change-photo-path="routes.changePhotoPath"
                :product-print-size="variant.printSizeName"
                :routes="routes"
                :product="product"
              />
              <product-section-art-dimensions
                v-if="upload"
                class="my-6 md:pl-8"
                :upload="upload"
                :routes="routes"
                :product="product"
              />
            </div>
            <product-customization-loading
              v-if="upload && isCustomizationLoading && product.isCustom"
              class="md:pl-8 my-6"
            />
            <product-customization-error
              v-else-if="upload && isCustomizationError && product.isCustom"
              class="md:pl-8 my-6"
            />
            <div v-else-if="upload">
              <div v-if="product.isCustom">
                <div
                  v-if="!mountUnavailable"
                  class="my-6 md:pl-8 flex items-center"
                >
                  <div class="flex flex-col flex-shrink-0">
                    <v-small-heading class="text-grey2">
                      Mount colour
                      <div class="tooltip">
                        <img src="~images/tooltip.png" alt="tooltip icon" />
                        <span class="tooltip-text"
                          >A <strong>mount</strong> is the cardboard window that
                          surrounds your artwork in the frame.</span
                        >
                      </div>
                    </v-small-heading>
                    <v-p :body-size="1">
                      {{ mountColor.name }}
                    </v-p>
                  </div>
                </div>
                <div class="my-6 md:pl-8 flex">
                  <product-color-switcher
                    class="mr-0"
                    v-model="mountColor"
                    :available-colors="availableMountColorsGroup"
                  />
                </div>
              </div>
              <div v-if="product.isCustom" class="my-6">
                <product-mount-type-options
                  :available-mount-type-options="availableMountTypeOptionsGroup"
                  v-model="mountType"
                />
              </div>
              <div v-if="isDoubleMount" class="my-6 md:pl-8 flex items-center">
                <div class="flex flex-col">
                  <v-small-heading class="text-grey2">
                    Accent mount colour
                  </v-small-heading>
                  <v-p :body-size="1">
                    {{ accentMountColor.name }}
                  </v-p>
                  <product-color-switcher
                    class="ml-auto my-6 flex"
                    v-model="accentMountColor"
                    :available-colors="availableMountColorsGroup"
                  />
                </div>
              </div>
              <div v-if="product.isCustom">
                <product-section-mount-dimensions
                  v-if="upload && !mountUnavailable"
                  class="md:pl-8"
                  v-model="mountDimensions"
                  :print-size="artDimensions"
                  :local-mount-dimensions="localMountDimensions"
                  :minimum-mount-dimensions="minimumMountDimensions"
                />
                <div
                  v-if="!mountUnavailable"
                  class="my-6 md:pl-8 flex items-center cursor-pointer"
                  @click="toggleMountOptionsExpanded"
                  style="
                    border: 1px solid silver;
                    padding: 24px 0 24px 24px;
                    border-radius: 4px;
                  "
                >
                  <v-small-heading class="text-grey2">
                    More mount options
                  </v-small-heading>
                  <v-arrow-down
                    class="ml-auto mr-7"
                    :class="mountOptionsExpanded ? 'transform rotate-180' : ''"
                  />
                </div>
                <div
                  v-if="mountOptionsExpanded"
                  class="bg-neutral rounded-sm py-8"
                >
                  <product-mount-options
                    v-if="availableMountOptions.length > 0"
                    :available-mount-options="availableMountOptions"
                    v-model="mountOption"
                    class="px-12"
                  />
                  <v-hr
                    v-if="availableMountOptions.length > 0 && linenAdditional"
                  />
                  <product-mount-fabrics
                    v-if="linenAdditional && linenMountColors.length > 0"
                    v-model="linenChosen"
                    :linen-additional="linenAdditional"
                    class="px-12"
                  />
                </div>
              </div>
              <div v-if="product.isCustom || product.isPersonalizedStandard">
                <product-section-foil-blocking
                  v-if="
                    foilBlockingAdditional && !(linenChosen || mountUnavailable)
                  "
                  v-model="foilBlockingOptions"
                  :foil-blocking-additional="foilBlockingAdditional"
                  :available-foil-blocking-colors="availableFoilBlockingColors"
                  class="mt-8"
                />
              </div>
              <v-hr class="mt-8" />
              <div v-if="product.isCustom">
                <product-section-size-summary
                  v-if="upload"
                  class="md:pl-8 pr-7 my-6"
                  :print-size="artDimensions"
                  :mount-size="mountDimensions"
                  :variant="variant"
                />
              </div>
            </div>
            <v-hr v-if="upload" />
            <div v-if="product.isCustom">
              <div class="mt-6 mb-6 md:pl-8">
                <product-cart-button
                  v-if="isUploadAndCustomizationsLoaded"
                  :variant="variant"
                  :price="price"
                  :upload-uuid="upload.uuid"
                  :is-custom-frame="true"
                  :print-size-id="printSizeId"
                  :mount-color="mountColor"
                  :mount-type="mountType"
                  :mount-option="mountOption"
                  :accent-mount-color="
                    isDoubleMount ? accentMountColor : undefined
                  "
                  :foil-blocking-options="foilBlockingOptions"
                  :product="product"
                  :foil-blocking-additional="foilBlockingAdditional"
                  :linen-chosen="linenChosen"
                  :linen-additional="linenAdditional"
                  :mount-dimensions="mountDimensions"
                  :routes="routes"
                  :is-product-available="isProductAvailable"
                />
                <product-cart-unavailable-button
                  v-else
                  :product="product"
                  :routes="routes"
                />
              </div>
            </div>
            <div
              v-if="product.isPersonalizedStandard || !product.isCustom"
              class="mt-6 mb-6 md:pl-8"
            >
              <product-cart-button
                v-if="isUploadAndCustomizationsLoaded"
                :variant="variant"
                :price="price"
                :upload-uuid="upload.uuid"
                :is-custom-frame="false"
                :print-size-id="printSizeId"
                :foil-blocking-options="foilBlockingOptions"
                :foil-blocking-additional="foilBlockingAdditional"
                :routes="routes"
                :is-product-available="isProductAvailable"
              />
              <product-cart-unavailable-button
                v-else
                :product="product"
                :routes="routes"
              />
            </div>
            <v-hr />
            <v-p
              :body-size="1"
              class="mt-8 md:mt-19 text-center md:mx-auto md:pb-4"
            >
              {{ product.description }}
            </v-p>
            <product-whats-included class="mt-20" :product="product" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import VCheckbox from "../Atoms/VCheckbox";
import VInput from "../Atoms/VInput";
import VH3 from "../Atoms/VH3";
import VH4 from "../Atoms/VH4";
import VP from "../Atoms/VP";
import VHr from "../Atoms/VHr";
import VDropdown from "../Atoms/VDropdown";
import VSmallHeading from "../Atoms/VSmallHeading";
import VArrowDown from "../Atoms/VArrowDown";
import ProductChevronCarousel from "./ProductChevronCarousel";
import ProductWhatsIncluded from "./ProductWhatsIncluded";
import ProductShipsInBadge from "./ProductShipsInBadge";
import ProductColorSwitcher from "./ProductColorSwitcher";
import ProductMountOptions from "./ProductMountOptions";
import ProductMountFabrics from "./ProductMountFabrics";
import ProductSectionArtType from "./ProductSectionArtType";
import ProductSectionArtDimensions from "./ProductSectionArtDimensions";
import ProductCustomizationLoading from "./ProductCustomizationLoading";
import ProductCustomizationError from "./ProductCustomizationError";
import ProductSectionMountDimensions from "./ProductSectionMountDimensions";
import ProductSectionFoilBlocking from "./ProductSectionFoilBlocking";
import ProductSectionSizeSummary from "./ProductSectionSizeSummary";
import ProductCartButton from "./ProductCartButton";
import ProductCartUnavailableButton from "./ProductCartUnavailableButton";
import ProductImageCarousel from "./ProductImageCarousel";
import ProductMountTypeOptions from "./ProductMountTypeOptions";
import FrameImagePreview from "../Preview/FrameImagePreview";
import StandardFramePreview from "../Preview/StandardFramePreview";
import CustomFramePreview from "../Preview/CustomFramePreview";
import ColorMarker from "../Products/ColorMarker";
import { fetchCart } from "../../lib/api/cart";
import { fetchAvailableCustomizationOptions } from "../../lib/api/customization";
import {
  fetchCustomFrame,
  fetchChevrons,
  fetchStandardFrame,
} from "../../lib/api/customFrame";
import {
  defaultMountDimensions,
  customFramePrice,
} from "../../lib/customization";
import { deserializeVariant } from "../../lib/serializers/variant";
import { maxFrameLongestSide, maxFrameShortestSide } from "../Upload/constants";

export default {
  name: "CustomProductDetails",
  components: {
    VH3,
    VH4,
    VP,
    VHr,
    VSmallHeading,
    VInput,
    VCheckbox,
    VDropdown,
    VArrowDown,
    ProductChevronCarousel,
    ProductWhatsIncluded,
    ProductShipsInBadge,
    ProductColorSwitcher,
    ProductMountOptions,
    ProductMountFabrics,
    ProductSectionArtType,
    ProductSectionArtDimensions,
    ProductCustomizationLoading,
    ProductCustomizationError,
    ProductSectionMountDimensions,
    ProductSectionFoilBlocking,
    ProductSectionSizeSummary,
    ProductCartButton,
    ProductCartUnavailableButton,
    ProductImageCarousel,
    ProductMountTypeOptions,
    FrameImagePreview,
    StandardFramePreview,
    CustomFramePreview,
    ColorMarker,
  },
  props: {
    upload: {
      type: Object,
      default: undefined,
    },
    initialProduct: {
      type: Object,
      required: true,
    },
    availableMountColors: {
      type: Array,
      required: true,
    },
    availableFoilBlockingColors: {
      type: Array,
      required: true,
    },
    cloneLineItemId: {
      type: Number,
      default: undefined,
    },

    routes: {
      type: Object,
      required: true,
    },
  },
  data() {
    const classicMountColors = this.availableMountColors.filter(
      (e) => !e.isLinen
    );
    return {
      product: this.initialProduct,
      productSlug: "",
      mountColor: classicMountColors[0],
      accentMountColor: classicMountColors[0],
      printSizeId: undefined,
      mountType: undefined,
      availableMountTypeOptions: [],
      mountOption: undefined,
      availableMountOptions: [],
      mouldingTypePrices: [],
      mountDimensions: {
        left: 6.5,
        right: 6.5,
        top: 6.5,
        bottom: 6.5,
      },
      foilBlockingAdditional: undefined,
      foilBlockingOptions: {
        chosen: false,
        line1: undefined,
        line2: undefined,
        color: this.availableFoilBlockingColors[0],
      },
      linenAdditional: undefined,
      linenChosen: false,
      chevrons: undefined,
      mountOptionsExpanded: false,
      currentImage: undefined,
      isCustomizationLoading: true,
      isCustomizationError: false,
      localMountDimensions: {
        left: 6.5,
        right: 6.5,
        top: 6.5,
        bottom: 6.5,
      },
    };
  },
  computed: {
    variant() {
      return deserializeVariant(this.product.variant);
    },
    isFloatMount() {
      return this.mountType && this.mountType.value === "float_mount";
    },
    isDoubleMount() {
      return this.mountType && this.mountType.value === "double_mount";
    },
    standardUpload() {
      if (this.upload && !this.upload.isCustom) {
        if (this.isMatchingUploadPrintSize) {
          return this.upload;
        }
      }

      return undefined;
    },
    framePreviewConfiguration() {
      let result = {};

      if (this.variant) {
        result = { ...result, ...this.variant.framePreviewConfiguration };
      }

      if (this.mountColor) {
        result = {
          ...result,
          ...this.mountColor.mountPattern,
          ...this.mountColor.mountBorderTopLeft,
          ...this.mountColor.mountBorderBottomRight,
        };
      }

      if (this.isFloatMount) {
        result = { ...result, applyMountShadow: true };
      } else {
        result = { ...result, applyMountBorder: true };
      }

      if (this.isDoubleMount) {
        result = {
          ...result,
          accentMount: {
            ...this.accentMountColor.mountPattern,
            ...this.accentMountColor.mountBorderTopLeft,
            ...this.accentMountColor.mountBorderBottomRight,
          },
        };
      }

      return result;
    },
    mountUnavailable() {
      if (this.mountType.value === "no_mount") {
        return true;
      }

      const { left, right, top, bottom } = this.mountOption;
      return left === 0 && right === 0 && top === 0 && bottom === 0;
    },
    minimumMountDimensions() {
      const lefts = this.availableMountOptions.map((e) => e.left);
      const rights = this.availableMountOptions.map((e) => e.right);
      const tops = this.availableMountOptions.map((e) => e.top);
      const bottoms = this.availableMountOptions.map((e) => e.bottom);

      return {
        left: Math.min(...lefts),
        right: Math.min(...rights),
        top: Math.min(...tops),
        bottom: Math.min(...bottoms),
      };
    },
    artDimensions() {
      if (!this.upload) {
        return null;
      }

      return {
        width: this.upload.printWidth,
        height: this.upload.printHeight,
      };
    },
    isUploadAndCustomizationsLoaded() {
      return (
        !this.isCustomizationLoading &&
        !this.isCustomizationError &&
        this.upload !== undefined
      );
    },
    classicMountColors() {
      return this.availableMountColors.filter((e) => !e.isLinen);
    },
    linenMountColors() {
      return this.availableMountColors.filter((e) => e.isLinen);
    },
    availableMountColorsGroup() {
      if (this.linenChosen) {
        return this.linenMountColors;
      } else {
        return this.classicMountColors;
      }
    },
    availableMountTypeOptionsGroup() {
      if (
        this.mountColor &&
        this.mountColor.allowFloatMount &&
        this.product &&
        this.product.allowFloatMount
      ) {
        return this.availableMountTypeOptions;
      }

      return this.availableMountTypeOptions.filter(
        (e) => e.value !== "float_mount"
      );
    },
    price() {
      if (!this.variant) {
        return undefined;
      }
      return customFramePrice({
        variant: this.variant,
        mouldingTypePrices: this.mouldingTypePrices,
        mountType: this.mountType,
        mountDimensions: this.mountDimensions,
        mountOption: this.mountOption,
        foilBlockingAdditional: this.foilBlockingOptions.chosen
          ? this.foilBlockingAdditional
          : undefined,
        linenAdditional: this.linenChosen ? this.linenAdditional : undefined,
        product: this.product,
      });
    },
    shouldShowImageCarousel() {
      return this.product.images.length > 0;
    },
    isProductAvailable() {
      if (!this.price) return false;

      const seperate = window.location.search.split("?");
      const localUrl = localStorage.getItem(seperate[1]);
      const parsedUrl = JSON.parse(localUrl);

      const printWidth = this.artDimensions.width;
      const printHeight = this.artDimensions.height;
      const mountWidth = this.mountDimensions.left + this.mountDimensions.right;
      const mountHeight =
        this.mountDimensions.top + this.mountDimensions.bottom;

      const border = Number(this.variant.framePreviewConfiguration.borderWidth);

      if (seperate[1] && this.product.isCustom) {
        const localMountWidth =
          parsedUrl.mount_dimensions.left + parsedUrl.mount_dimensions.right;
        const localMountHeight =
          parsedUrl.mount_dimensions.top + parsedUrl.mount_dimensions.bottom;
        const localFrameWidth = printWidth + localMountWidth + border * 2;
        const localFrameHeight = printHeight + localMountHeight + border * 2;
        if (localFrameWidth > localFrameHeight) {
          if (
            localFrameWidth < maxFrameLongestSide &&
            localFrameHeight < maxFrameShortestSide
          )
            return true;
        } else {
          if (
            localFrameHeight < maxFrameLongestSide &&
            localFrameWidth < maxFrameShortestSide
          )
            return true;
        }
        return false;
      } else {
        let frameWidth;
        let frameHeight;
        frameWidth = printWidth + mountWidth + border * 2;
        frameHeight = printHeight + mountHeight + border * 2;
        if (frameWidth > frameHeight) {
          if (
            frameWidth < maxFrameLongestSide &&
            frameHeight < maxFrameShortestSide
          )
            return true;
        } else {
          if (
            frameHeight < maxFrameLongestSide &&
            frameWidth < maxFrameShortestSide
          )
            return true;
        }
        return false;
      }
    },
    isStandardProductAvailable() {
      if (!this.price) {
        return false;
      } else {
        return true;
      }
    },
  },
  async mounted() {
    const seperate = window.location.search.split("?");
    const localUrl = localStorage.getItem(seperate[1]);
    const parsedUrl = JSON.parse(localUrl);
    const mountColors = this.classicMountColors;
    if (seperate[1] && this.product.isCustom) {
      this.localMountDimensions = parsedUrl.mount_dimensions;
    }
    if (seperate[1]) {
      const filteredItem = mountColors.filter((item) => {
        return item.id == parsedUrl.mount_color_id;
      });
      if (this.product.isCustom) {
        this.localMountDimensions = parsedUrl.mount_dimensions;
        this.mountColor = filteredItem[0];
        this.accentMountColor = filteredItem[0];
      }
      if (parsedUrl.foil_blocking) {
        this.foilBlockingOptions.chosen = true;
        this.foilBlockingOptions.line1 = parsedUrl.foil_blocking.line1;
        this.foilBlockingOptions.line2 = parsedUrl.foil_blocking.line2;
        this.foilBlockingOptions.color.display =
          parsedUrl.foil_blocking.color.display;
      } else {
        this.foilBlockingOptions.chosen = false;
      }
    }
    await this.loadCustomizationOptions();
    await this.loadChevrons();
    await this.standardloadChevrons();
    if (this.cloneLineItemId) {
      await this.loadClonedOptions(this.cloneLineItemId);
    }
  },
  methods: {
    toggleMountOptionsExpanded() {
      this.mountOptionsExpanded = !this.mountOptionsExpanded;
    },
    async loadCustomizationOptions() {
      if (this.upload === undefined) {
        return;
      }

      this.isCustomizationLoading = true;
      try {
        const options = await fetchAvailableCustomizationOptions(
          this.routes.availableOptionsPath,
          this.upload.uuid
        );
        const seperate = window.location.search.split("?");
        const localUrl = localStorage.getItem(seperate[1]);
        const parsedUrl = JSON.parse(localUrl);

        //edit item print size
        if (seperate[1] && this.product.isCustom) {
          this.printSizeId = parsedUrl.print_size_id;
        } else {
          this.printSizeId = options.printSizeId;
        }

        this.mouldingTypePrices = options.mouldingTypePrices;
        //edit item mount type set
        if (seperate[1] && this.product.isCustom) {
          if (parsedUrl.mount_type_id === 1) {
            this.availableMountTypeOptions = options.mountTypes;
            this.mountType = options.mountTypes[0];
          } else if (parsedUrl.mount_type_id === 3) {
            this.availableMountTypeOptions = options.mountTypes;
            this.mountType = options.mountTypes[1];
          } else if (parsedUrl.mount_type_id === 4) {
            this.availableMountTypeOptions = options.mountTypes;
            this.mountType = options.mountTypes[2];
          }
        } else {
          this.availableMountTypeOptions = options.mountTypes;
          this.mountType = options.mountTypes[0];
        }
        //edit item mount option set
        if (seperate[1] && this.product.isCustom) {
          if (parsedUrl.mount_option_id === 1) {
            this.availableMountOptions = options.mountOptions;
            this.mountOption = options.mountOptions[0];
          } else if (parsedUrl.mount_option_id === 2) {
            this.availableMountOptions = options.mountOptions;
            this.mountOption = options.mountOptions[1];
          } else if (parsedUrl.mount_option_id === 4) {
            this.availableMountOptions = options.mountOptions;
            this.mountOption = options.mountOptions[2];
          }
        } else {
          this.availableMountOptions = options.mountOptions;
          this.mountOption = options.mountOptions[0];
        }

        this.foilBlockingAdditional = options.foilBlockingAdditional;
        this.linenAdditional = options.linenAdditional;
      } catch (e) {
        console.error(e);
        this.isCustomizationError = true;
      } finally {
        this.isCustomizationLoading = false;
      }
    },
    async switchCustomFrame(productSlug) {
      this.productSlug = productSlug;
      try {
        const product = await fetchCustomFrame(
          this.routes.showProductPath,
          productSlug
        );
        if (this.productSlug !== productSlug) {
          return;
        }

        this.product = product;
        this.currentImage = undefined;

        window.history.pushState(
          { productSlug },
          product.name,
          "/products/" + productSlug
        );
      } catch (e) {
        console.error(e);
      }
    },
    async switchStandardFrame(productSlug) {
      this.productSlug = productSlug;
      try {
        const product = await fetchStandardFrame(
          this.routes.showProductPath,
          productSlug
        );
        if (this.productSlug !== productSlug) {
          return;
        }

        this.product = product;
        this.currentImage = product.images[0];

        window.history.pushState(
          { productSlug },
          product.name,
          "/products/" + productSlug
        );
      } catch (e) {
        console.error(e);
      }
    },
    async loadChevrons() {
      try {
        this.chevrons = await fetchChevrons(this.routes.chevronsPath);
      } catch (e) {
        console.error(e);
      }
    },
    async standardloadChevrons() {
      try {
        this.chevrons = await fetchChevrons(
          `${this.routes.chevronsPath}?print_size_id=${this.variant.printSizeId}`
        );
      } catch (e) {
        console.error(e);
      }
    },
    async loadClonedOptions(lineItemId) {
      try {
        const cart = await fetchCart(this.routes);
        const lineItem = cart.lineItems.find((e) => e.id === lineItemId);

        if (!lineItem) {
          return;
        }

        this.mountDimensions = lineItem.mountDimensions;
        this.mountColor = this.availableMountColors.find(
          (e) => e.id === lineItem.mountColor.id
        );
        this.mountType = this.availableMountTypeOptions.find(
          (e) => e.id === lineItem.mountType.id
        );
        this.mountOption = this.availableMountOptions.find(
          (e) => e.id === lineItem.mountOption.id
        );
        this.linenChosen = lineItem.additionals.linenChosen;
        this.foilBlockingOptions = lineItem.additionals.foilBlocking;
        if (lineItem.accentMountColor) {
          this.accentMountColor = this.availableMountColors.find(
            (e) => e.id === lineItem.accentMountColor.id
          );
        }
      } catch (e) {
        console.error(e);
      }
    },
    changeCurrentImage(image) {
      this.currentImage = image;
    },
  },
  watch: {
    mountType(newValue) {
      if (newValue.value === "no_mount") {
        this.mountDimensions = { left: 0, right: 0, top: 0, bottom: 0 };
        this.foilBlockingOptions = {
          chosen: false,
          line1: undefined,
          line2: undefined,
          color: this.availableFoilBlockingColors[0],
        };
      } else if (newValue.value !== "custom") {
        this.mountDimensions = defaultMountDimensions(this.mountOption);
      }
    },
    mountOption(newValue) {
      if (this.mountDimensions !== "custom") {
        this.mountDimensions = defaultMountDimensions(newValue);
        this.localMountDimensions = defaultMountDimensions(newValue);
      }
    },
    mountColor(newValue) {
      if (this.isFloatMount && !newValue.allowFloatMount) {
        this.mountType = this.availableMountTypeOptions.find(
          (e) => e.value !== "float_mount"
        );
      }
    },
    product(newValue) {
      if (this.isFloatMount && !newValue.allowFloatMount) {
        this.mountType = this.availableMountTypeOptions.find(
          (e) => e.value !== "float_mount"
        );
      }
    },
    linenChosen(newValue) {
      if (newValue) {
        this.mountColor = this.linenMountColors[0];
        this.accentMountColor =
          this.linenMountColors[1] || this.linenMountColors[0];
        this.foilBlockingOptions = {
          chosen: false,
          line1: undefined,
          line2: undefined,
          color: this.availableFoilBlockingColors[0],
        };
      } else {
        this.mountColor = this.classicMountColors[0];
        this.accentMountColor =
          this.classicMountColors[1] || this.classicMountColors[0];
      }
    },
    async upload(newValue) {
      await this.loadCustomizationOptions(newValue);
    },
  },
};
</script>

<style>
.tooltip {
  top: 7px;
  position: relative;
  display: inline-block;
}

.tooltip .tooltip-text {
  visibility: hidden;
  width: 330px;
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

.tooltip:hover .tooltip-text {
  visibility: visible;
}
</style>
