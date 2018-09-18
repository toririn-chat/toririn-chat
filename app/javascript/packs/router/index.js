import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import ChatRoot from '../components/ChatRoot.vue'
import Root from '../components/Root.vue'
import Rooms from '../components/Rooms.vue'
import Room from '../components/Room.vue'
import Chat from '../components/Chat.vue'

const routes = [
  {
    path: '/',
    name: 'chat_root',
    component: ChatRoot
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
