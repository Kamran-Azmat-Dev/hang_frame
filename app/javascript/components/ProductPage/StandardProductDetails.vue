<template>
  <div class="flex flex-col md:flex-row">
    <div class="w-full">
      <div class="w-full md:ml-auto md:mr-0 md:max-w-xl-1/2 top-96">
        <product-image-carousel
          v-if="shouldShowImageCarousel"
          class="mt-4 mb-4 md:mt-7"
          :product="product"
          :variant="variant"
          :current-image="currentImage"
          :upload="upload"
          @change="(e) => changeCurrentImage(e)"
        />
      </div>
      <div class="w-full md:ml-auto md:mr-0 md:max-w-xl-1/2 md:sticky top-96">
        <div class="md:ml-auto md:mr-0 px-6 md:pl-6 md:pr-0">
          <standard-frame-preview
            v-if="isFirstImageActive"
            class="w-full"
            :frame-photo-url="variant.framePhotoUrl"
            :frame-photo-width="variant.framePhotoWidth"
            :frame-photo-height="variant.framePhotoHeight"
            :frame-preview-x="variant.framePreviewX"
            :frame-preview-y="variant.framePreviewY"
            :frame-preview-width="variant.framePreviewWidth"
            :frame-preview-height="variant.framePreviewHeight"
            :upload="upload"
          />
          <frame-image-preview v-else :image="currentImage" />
        </div>
      </div>
    </div>
    <div class="w-full bg-white">
      <div class="w-full md:ml-0 md:mr-auto md:max-w-xl-1/2">
        <div class="md:ml-0 md:mr-auto px-6 md:pl-0 md:pl-6">
          <a
            href="/t/standard"
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
          >
            &lt; Back to frames
          </a>
          <div class="xl:pl-30 pb-25">
            <v-h3 class="text-center mt-10 md:mt-20">
              {{ product.name }}
            </v-h3>
            <v-p class="text-center" :body-size="2">
              {{ product.shortDescription }}
            </v-p>
            <product-chevron-carousel
              v-if="chevrons && chevrons.length > 1"
              class="mt-10"
              :chevrons="chevrons"
              :initial-product-slug="product.slug"
              @change="(e) => switchStandardFrame(e.productSlug)"
            />
            <product-ships-in-badge :number="2" class="my-8" />
            <product-section-art-type
              v-if="standardUpload"
              class="my-6 md:pl-8"
              :upload="upload"
              :change-photo-path="routes.changePhotoPath"
              :product-print-size="variant.printSizeName"
              :is-mismatched-upload-print-size="!isMatchingUploadPrintSize"
              :product="product"
              :routes="routes"
            />
            <product-section-art-dimensions
              v-if="standardUpload"
              class="my-6 md:pl-8"
              :upload="upload"
              :routes="routes"
              :product="product"
            />
            <v-hr v-if="standardUpload" />
            <div class="mt-6 mb-6 md:pl-8">
              <product-cart-button
                v-if="standardUpload"
                :variant="variant"
                :price="price"
                :upload-uuid="upload.uuid"
                :is-custom-frame="false"
                :print-size-id="printSizeId"
                :routes="routes"
                :is-product-available="isProductAvailable"
              />
              <product-cart-unavailable-button
                v-else
                :product-print-size="variant.printSizeName"
                :is-mismatched-upload-print-size="!isMatchingUploadPrintSize"
                :product="product"
                :routes="routes"
                :upload="upload"
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
import VH3 from "../Atoms/VH3";
import VH4 from "../Atoms/VH4";
import VP from "../Atoms/VP";
import VHr from "../Atoms/VHr";
import VSmallHeading from "../Atoms/VSmallHeading";
import ProductWhatsIncluded from "./ProductWhatsIncluded";
import ProductShipsInBadge from "./ProductShipsInBadge";
import ProductSectionArtType from "./ProductSectionArtType";
import ProductChevronCarousel from "./ProductChevronCarousel";
import ProductSectionArtDimensions from "./ProductSectionArtDimensions";
import ProductCartButton from "./ProductCartButton";
import ProductCartUnavailableButton from "./ProductCartUnavailableButton";
import ProductImageCarousel from "./ProductImageCarousel";
import FrameImagePreview from "../Preview/FrameImagePreview";
import StandardFramePreview from "../Preview/StandardFramePreview";
import { deserializeVariant } from "../../lib/serializers/variant";
import { fetchChevrons, fetchStandardFrame } from "../../lib/api/customFrame";

export default {
  name: "StandardProductDetails",
  components: {
    VH3,
    VH4,
    VP,
    VHr,
    VSmallHeading,
    ProductChevronCarousel,
    ProductWhatsIncluded,
    ProductShipsInBadge,
    ProductSectionArtType,
    ProductSectionArtDimensions,
    ProductCartButton,
    ProductCartUnavailableButton,
    ProductImageCarousel,
    FrameImagePreview,
    StandardFramePreview,
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
    routes: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      product: this.initialProduct,
      productSlug: "",
      printSizeId: undefined,
      mountType: undefined,
      currentImage: this.initialProduct.images[0],
      chevrons: undefined,
    };
  },
  computed: {
    variant() {
      return deserializeVariant(this.product.variant);
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
    standardUpload() {
      if (this.upload && !this.upload.isCustom) {
        if (this.isMatchingUploadPrintSize) {
          return this.upload;
        }
      }

      return undefined;
    },
    isMatchingUploadPrintSize() {
      if (!this.upload) {
        return false;
      }

      return this.upload.printSizeId === this.variant.printSizeId;
    },
    price() {
      if (!this.variant) {
        return undefined;
      }

      return this.variant.price;
    },
    shouldShowImageCarousel() {
      return this.product.images.length > 1;
    },
    isFirstImageActive() {
      const firstImage = this.product.images[0];
      const currentImage = this.currentImage;

      if (!firstImage || !currentImage) {
        return false;
      }

      return firstImage.id === currentImage.id;
    },
    isProductAvailable() {
      if (!this.price) {
        return false;
      } else {
        return true;
      }
    },
  },
  async mounted() {
    await this.loadChevrons();
  },
  methods: {
    changeCurrentImage(image) {
      this.currentImage = image;
    },
    async loadChevrons() {
      try {
        this.chevrons = await fetchChevrons(
          `${this.routes.chevronsPath}?print_size_id=${this.variant.printSizeId}`
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
  },
};
</script>
