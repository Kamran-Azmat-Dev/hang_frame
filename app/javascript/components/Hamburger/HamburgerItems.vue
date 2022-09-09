<template>
  <div>
    <hamburger-item
      title="How it works"
      url="https://hangframing.com/how-it-works"
    />
    <hamburger-item
      title="Support"
      url="https://hangframing.com/support"
    />
  </div>
</template>

<script>
import HamburgerItem from './HamburgerItem'

export default {
  name: 'HamburgerItems',
  components: {
    HamburgerItem,
  },
}
</script>
