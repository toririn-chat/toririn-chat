import 'es6-promise/auto' // for vuex on IE 11
import Vue from 'vue'
import i18n from './i18n'
import router from './router'
import cable from './cable'
import App from './components/App.vue'

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'));
  const app = new Vue({ i18n, router, el: 'app', components: { App } });
})
