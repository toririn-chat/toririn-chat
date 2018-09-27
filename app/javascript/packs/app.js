import 'es6-promise/auto' // for vuex on IE 11
import Vue from 'vue'
import i18n from './i18n'
import router from './router'
import App from './components/App.vue'
import ActionCable from 'actioncable';

const cable = ActionCable.createConsumer();
Vue.prototype.$cable = cable;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({ i18n, router, el: 'app', components: { App } })
})
