import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import Home from './components/Home'

const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  }, {
    path: '/start',
    name: 'start',
    component: Home
  }
]
export default new VueRouter({routes, mode: 'history'})
