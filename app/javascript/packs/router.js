import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import Root from './components/Root'
import Dashboard from './components/Dashboard'

const routes = [
  {
    path: '/',
    name: 'root',
    component: Root
  }, {
    path: '/dashboard',
    name: 'dashboard',
    component: Dashboard
  }
]
export default new VueRouter({routes, mode: 'history'})
