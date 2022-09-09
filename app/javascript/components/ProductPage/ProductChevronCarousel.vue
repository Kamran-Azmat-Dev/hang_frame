<template>
  <div class="relative">
    <div
      class="hidden md:block absolute -left-24 top-1/2 transform -translate-y-1/2 z-20 cursor-pointer"
      @click="selectPreviousChevron()"
    >
      <img
        src="~images/carousel-next.svg"
        class="w-6 h-6 transform rotate-180"
      />
    </div>
    <flicking
      :options="{
        gap: -50,
        circular: false,
        collectStatistics: false,
        autoResize: true,
        bound: false,
        isConstantSize: false,
        isEqualSize: true,
        zIndex: 20,
      }"
      :tag="'div'"
      :viewport-tag="'div'"
      :camera-tag="'div'"
      ref="flicking"
      @select="e => chevronSelected(e)"
      @move-start="chevronMoveStarted()"
      @move="chevronMove()"
      @move-end="e => chevronMoveEnded(e)"
    >
      <chevron-preview
        :image-url="chevron.chevronImageUrl"
        :is-selected="isSelected(chevron, index)"
        v-for="(chevron, index) in chevrons"
        :key="chevron.productSlug"
      />
    </flicking>
    <div
      class="hidden md:block absolute -right-24 top-1/2 transform -translate-y-1/2 z-20 cursor-pointer"
      @click="selectNextChevron()"
    >
      <img
        src="~images/carousel-next.svg"
        class="w-6 h-6"
      />
    </div>
  </div>
</template>

<script>
import ChevronPreview from '../Chevrons/ChevronPreview'

export default {
  name: 'ProductChevronCarousel',
  components: {
    ChevronPreview,
  },
  props: {
    chevrons: {
      type: Array,
      required: true,
    },
    initialProductSlug: {
      type: String,
      default: undefined,
    },
  },
  data() {
    return {
      moveInProgress: false,
      moveNearestChevronIndex: undefined,
      selectedChevronIndex: this.chevrons.findIndex(e => e.productSlug === this.initialProductSlug),
    }
  },
  computed: {
    selectedChevron() {
      return this.chevrons[this.selectedChevronIndex]
    },
  },
  mounted() {
    if (!this.selectedChevronIndex) {
      return
    }

    this.$refs.flicking.moveTo(this.selectedChevronIndex, 0)
  },
  methods: {
    isSelected(chevron, index) {
      if (this.moveNearestChevronIndex) {
        return index === this.moveNearestChevronIndex
      }

      if (!this.selectedChevron) {
        return false
      }

      return chevron.productSlug === this.selectedChevron.productSlug
    },
    chevronSelected(event) {
      this.$refs.flicking.moveTo(event.index, 200)
    },
    chevronMoveStarted() {
      this.moveInProgress = true
      this.moveNearestChevronIndex = undefined
    },
    chevronMove() {
      if (this.moveInProgress) {
        const currentPanel = this.$refs.flicking.getCurrentPanel()
        const viewport = currentPanel.viewport
        const nearestPanel = viewport.getNearestPanel()

        this.moveNearestChevronIndex = nearestPanel.state.index
      }
    },
    chevronMoveEnded(event) {
      this.moveInProgress = false
      this.moveNearestChevronIndex = undefined

      if (this.selectedChevronIndex !== event.index) {
        this.selectedChevronIndex = event.index
        this.$emit('change', this.chevrons[this.selectedChevronIndex])
      }
    },
    selectPreviousChevron() {
      this.$refs.flicking.prev()
    },
    selectNextChevron() {
      this.$refs.flicking.next()
    },
  },
}
</script>
