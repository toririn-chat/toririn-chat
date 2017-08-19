import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import Root from './components/Root'

const routes = [
  {
    path: '/',
    name: 'root',
    component: Root
  }, {
    path: '/signin',
    name: 'signin',
    component: Root
  }, {
    path: '/signup',
    name: 'signup',
    component: Root
  }
]
export default new VueRouter({routes, mode: 'history'})
