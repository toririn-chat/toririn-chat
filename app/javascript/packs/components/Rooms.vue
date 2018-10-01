<template>
<div>
  <nav-bar />
  <div class="container">
    <b-breadcrumb class="mt-3" :items="breadcrumb" />
    <div class="tc-theme-light">
      <b-button variant="primary" v-b-modal.new_room>新規作成</b-button>
      <table class="table table-hover mt-3">
        <thead class="thead-light">
          <tr>
            <th scope="col">チャットルーム名</th>
            <th scope="col">作成日時</th>
            <th scope="col">備考</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="room in rooms">
            <td>
              <router-link :to="{ name: 'room', params: { id: room.id }}">{{ room.name }}</router-link>
            </td>
            <td>{{ room.created_at | moment }}</td>
            <td>{{ room.description }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <div class="tc-theme-light">
    <b-modal id="new_room" ref="new_room" size="sm" title="新規作成" ok-title="送信" cancel-title="キャンセル" @ok="createRoom" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
      <b-alert variant="info" :show="feedbacks['info'] !== undefined">
        <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
        <span>{{ feedbacks['info'] }}</span>
      </b-alert>
      <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
        {{ feedbacks['error'] }}
      </b-alert>
      <b-form-group label="チャットルーム名" :feedback="feedbacks['room.name']" :state="states['room.name']">
        <b-input-group>
          <b-form-input type="text" v-model="room.name" />
        </b-input-group>
      </b-form-group>
    </b-modal>
  </div>
</div>
</template>
<script>
import Vue from 'vue'
import axios from 'axios'
import moment from 'moment'
import NavBar from './NavBar.vue'
import feedbacks from '../plugins/feedbacks'
export default {
  mixins: [feedbacks],
  components: {
    NavBar
  },
  data() {
    return {
      rooms: [],
      room: {
        name: ''
      },
      breadcrumb: [{
        text: 'チャットルーム一覧',
        active: true
      }]
    }
  },
  beforeCreate() {
    document.body.className = 'rooms';
  },
  mounted() {
    this.getRooms();
  },
  filters: {
    moment(date) {
      moment.locale('ja');
      return moment(date).format('llll');
    }
  },
  methods: {
    getRooms() {
      let vm = this;
      axios({
        url: '/api/rooms',
        method: 'get'
      }).then(function(response) {
        vm.rooms = response.data;
      }).catch(vm.onFeedbacksErrors)
    },
    createRoom(event) {
      event.preventDefault();
      let vm = this;
      let form = new FormData();
      form.set('room[name]', vm.room.name);
      axios({
        resource: 'room',
        url: '/api/rooms',
        method: 'post',
        headers: { 'Content-Type': 'multipart/form-data' },
        data: form,
        onUploadProgress: vm.onFeedbacksProgress
      }).then(function(response) {
        let room = response.data;
        vm.rooms.unshift(room);
        Vue.set(vm.room, 'name', '');
        vm.$refs.new_room.hide();
      }).catch(vm.onFeedbacksErrors)
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
body.rooms {
  background-color: lighten($tc-color-light, 30%);
}
div.tc-theme-light {
  button.btn-primary {
    border-radius: 0.25rem;
    border: 0 none;
    color: $tc-color-light;
    background-color: $tc-color-dark;
    &:hover {
      color: darken($tc-color-light, 15%);
      background-color: daraken($tc-color-dark, 30%);
    }
  }
}
</style>
