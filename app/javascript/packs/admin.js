import Vue from 'vue/dist/vue.esm.js'
import CustomFramePreview from '../components/Preview/CustomFramePreview'

const globalComponents = {
  'CustomFramePreview': CustomFramePreview,
}


document.addEventListener('DOMContentLoaded', function() {
  const preview = document.getElementById('worksheet-frame-preview')
  if (preview) {
    console.log(preview)
    new Vue({
      el: preview,
      components: globalComponents
    })
  }
})
