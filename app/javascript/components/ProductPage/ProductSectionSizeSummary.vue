<template>
  <div>
    <div class="flex">
      <v-p
        :body-size="1"
        class="text-grey50"
      >
        Print size
      </v-p>
      <v-p
        :body-size="1"
        class="text-grey ml-auto mr-0"
      >
        {{ formattedPrintWidth }} x {{ formattedPrintHeight }}cm
      </v-p>
    </div>
    <div class="flex">
      <v-p
        :body-size="1"
        class="text-grey50"
      >
        Overall frame size
      </v-p>
      <v-p
        :body-size="1"
        class="text-grey ml-auto mr-0"
      >
        {{ formattedFrameWidth}} x {{ formattedFrameHeight }}cm
      </v-p>
    </div>
  </div>
</template>

<script>
import VP from '../Atoms/VP'
import { formatFrameDimension } from '../../display'

export default {
  name: 'ProductSectionSizeSummary',
  components: {
    VP,
  },
  props: {
    printSize: {
      type: Object,
      required: true,
    },
    mountSize: {
      type: Object,
      required: true,
    },
    variant: {
      type: Object,
      required: true,
    },
  },
  computed: {
    frameSize() {
      const result = {
        width: this.printSize.width + this.mountSize.left + this.mountSize.right,
        height: this.printSize.height + this.mountSize.top + this.mountSize.bottom,
      }

      if (this.variant.framePreviewConfiguration && this.variant.framePreviewConfiguration.borderWidth) {
        result.width += 2 * this.variant.framePreviewConfiguration.borderWidth
        result.height += 2 * this.variant.framePreviewConfiguration.borderWidth
      }

      return result
    },
    formattedPrintWidth() {
      return formatFrameDimension(this.printSize.width)
    },
    formattedPrintHeight() {
      return formatFrameDimension(this.printSize.height)
    },
    formattedFrameWidth() {
      return formatFrameDimension(this.frameSize.width)
    },
    formattedFrameHeight() {
      return formatFrameDimension(this.frameSize.height)
    }
  },
}
</script>
