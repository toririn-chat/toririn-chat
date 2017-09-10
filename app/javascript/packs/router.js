import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import Root from './components/Root'
import Rooms from './components/Rooms'

const routes = [
  {
    path: '/',
    name: 'root',
    component: Root
  }, {
    path: '/rooms',
    name: 'rooms',
    component: Rooms
  }
]
export default new VueRouter({routes, mode: 'history'})
