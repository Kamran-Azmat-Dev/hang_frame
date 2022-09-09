<template>
  <div>
    <div class="bg-grey text-neutral flex flex-col items-center pt-16 md:py-32">
      <div class="w-full max-w-screen-xl px-6">
        <div class="grid grid-cols-2 md:grid-cols-6 gap-x-5 gap-y-10">
          <div class="flex items-center md:items-start md:flex-col col-span-2 md:col-span-1">
            <img
              src="~images/logo-white.svg"
              class="w-25 h-13"
            />
            <div class="ml-18 md:ml-0 md:mt-16 flex">
              <a href="https://www.instagram.com/hangframing/"><img class="w-5 h-5 mr-5" src="~images/instagram.svg" /></a>
              <a href="https://www.facebook.com/hangframing/"><img class="w-5 h-5 mr-5" src="~images/facebook.svg" /></a>
              <a href="https://www.pinterest.com/hangframing/"><img class="w-5 h-5 mr-5" src="~images/pinterest.svg" /></a>
            </div>
          </div>
          <div>
            <div class="text-sm font-bold tracking-wide uppercase pb-4 md:pb-8">
              Start framing
            </div>
            <ul>
              <li class="mb-4"><a class="hover:underline" :href="routes.allProductsPath">Browse all frames</a></li>
              <li class="mb-4"><a class="hover:underline" :href="routes.digitalUploadPath">Upload a photo</a></li>
              <li class="mb-4"><a class="hover:underline" :href="routes.originalArtUploadPath">Frame an original</a></li>
            </ul>
          </div>
          <div class="hidden md:block">
            <div class="text-sm font-bold tracking-wide uppercase pb-4 md:pb-8">
              How it works
            </div>
            <ul>
              <li class="mb-4"><a class="hover:underline" href="https://hangframing.com/materials-sustainability">Materials &amp; sustainability</a></li>
              <li class="mb-4"><a class="hover:underline" href="https://hangframing.com/pricing">Pricing</a></li>
              <li class="mb-4"><a class="hover:underline" href="https://hangframing.com/our-story">Our story</a></li>
            </ul>
          </div>
          <div>
            <div class="text-sm font-bold tracking-wide uppercase pb-4 md:pb-8">
              Support
            </div>
            <ul>
              <li class="mb-4"><a class="hover:underline" href="https://hangframing.com/services">Our services</a></li>
              <li class="mb-4"><a class="hover:underline" href="https://hangframing.com/blog">Inspiration</a></li>
              <li class="mb-4"><a class="hover:underline" href="https://hangframing.com/faq">FAQs</a></li>
              <li class="mb-4"><a class="hover:underline" href="https://hangframing.com/contact">Contact</a></li>
            </ul>
          </div>
          <div class="col-span-2">
            <div class="text-sm font-bold tracking-wide uppercase pb-4 md:pb-8">
              Sign up for email updates
            </div>
            <form
              ref="newsletterForm"
              action="/newsletter"
              method="POST"
            >
              <v-input-with-button
                placeholder="Enter your email*"
                button-label="Submit"
                name="email"
                color="dark"
                value=""
                @buttonClick="submitNewsletterForm"
              />
            </form>
          </div>
        </div>
      </div>
    </div>
    <div class="flex flex-col items-center py-10 text-neutral bg-grey md:text-grey md:bg-white">
      <div class="w-full max-w-screen-xl px-6 flex flex-col-reverse text-xs md:flex-row">
        <div class="text-center text-grey2 my-5 md:text-left md:text-grey md:my-0">&copy; 2021 Hang Framing Ltd.</div>
        <ul class="ml-auto mr-auto flex flex-col flex-wrap text-center md:mr-0 md:flex-row md:text-left">
          <li class="my-3 md:my-0 md:mr-4"><a class="hover:underline" href="https://www.hangframing.com/terms-conditions">Terms &amp; conditions</a></li>
          <li class="my-3 md:my-0"><a class="hover:underline" href="https://hangframing.com/privacy-policy">Privacy policy</a></li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import VInputWithButton from './Atoms/VInputWithButton'

export default {
  name: 'PageFooter',
  components: {
    VInputWithButton,
  },
  props: {
    routes: {
      type: Object,
      required: true,
    },
  },
  methods: {
    submitNewsletterForm() {
      this.$refs.newsletterForm.submit()
    }
  }
}
</script>
