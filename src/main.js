import Vue from 'vue'
import App from './App.vue'
import './registerServiceWorker'
import router from './router'
import store from './store'
import OwUI from 'overwatch-ui'
import 'overwatch-ui/dist/overwatch-ui.css'
Vue.use(OwUI)
Vue.use(OwUI.plugins.$owAlert)

Vue.config.productionTip = false

new Vue({
  components: {
    ...OwUI.Components
  },
  router,
  store,
  render: h => h(App)
}).$mount('#app')
