import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import Root from './components/Root'
import Rooms from './components/Rooms'
import Room from './components/Room'
import Chat from './components/Chat'

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
  }, {
    path: '/chats/:id',
    name: 'chat',
    component: Chat
  }
]
export default new VueRouter({routes, mode: 'history'})
