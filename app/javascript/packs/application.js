import 'es6-promise/auto' // for vuex
import Vue from 'vue'
import i18n from './i18n'
import router from './router'
import App from './components/App.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({ i18n, router, el: 'app', components: { App } })
})
