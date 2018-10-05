import 'babel-polyfill'
import 'es6-promise/auto' // for IE 11 and Edge
import 'formdata-polyfill' // for IE 11 and Edge
import Vue from 'vue'
import i18n from './i18n'
import router from './router'
import App from './components/App.vue'

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'));
  const app = new Vue({ i18n, router, el: 'app', components: { App } });
})
