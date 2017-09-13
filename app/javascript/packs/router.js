import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import Root from './components/Root'
import Rooms from './components/Rooms'
import Room from './components/Room'

const routes = [
  {
    path: '/',
    name: 'root',
    component: Root
  }, {
    path: '/rooms',
    name: 'rooms',
    component: Rooms
  }, {
    path: '/rooms/:id',
    name: 'room',
    component: Room
  }
]
export default new VueRouter({routes, mode: 'history'})
