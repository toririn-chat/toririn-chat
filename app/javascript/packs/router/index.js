import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import Root from '../components/Root.vue'
import Profile from '../components/Profile.vue'
import Rooms from '../components/Rooms.vue'
import Room from '../components/Room.vue'
import Chat from '../components/Chat.vue'
import ChatSignin from '../components/ChatSignin.vue'
import ChatConfig from '../components/ChatConfig.vue'

const routes = [
  {
    path: '/',
    name: 'root',
    component: Root
  }, {
    path: '/profile',
    name: 'profile',
    component: Profile
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
  }, {
    path: '/chats/:id/signin',
    name: 'chat_signin',
    component: ChatSignin
  }, {
    path: '/chats/:id/config',
    name: 'chat_config',
    component: ChatConfig
  }
]
export default new VueRouter({routes, mode: 'history'})
