import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import Root from './components/Root'

const routes = [
  {
    path: '/',
    name: 'root',
    component: Root
  }
]
export default new VueRouter({routes, mode: 'history'})
