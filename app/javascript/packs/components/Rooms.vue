<template>
<div>
  <nav-bar />
  <div class="container">
    <b-breadcrumb class="mt-3" :items="breadcrumb" />
    <div class="tc-theme-light">
      <b-button variant="primary" v-b-modal.new_room>
        新規作成
      </b-button>
      <table class="table table-hover mt-3">
        <thead class="thead-light">
          <tr>
            <th scope="col">チャットルーム名</th>
            <th scope="col">作成日時</th>
            <th scope="col">管理者数</th>
            <th scope="col">書き込み数</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="room in rooms">
            <td>
              <router-link :to="{ name: 'room', params: { id: room.id }}">{{ room.name }}</router-link>
            </td>
            <td>{{ room.created_at }}</td>
            <td>{{ room.users_count }}</td>
            <td>{{ room.messages_count }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <div class="tc-theme-light">
    <b-modal id="new_room" ref="new_room" size="sm" title="新規作成" ok-title="送信" cancel-title="キャンセル" @ok="createRoom" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
      <b-alert variant="info" :show="feedbacks['info'] !== undefined">
        <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
        <span>{{feedbacks['info']}}</span>
      </b-alert>
      <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
        {{feedbacks['error']}}
      </b-alert>
      <b-form-group label="チャットルーム名" :feedback="feedbacks['name']" :state="states['name']">
        <b-input-group>
          <b-form-input type="text" v-model="name" />
        </b-input-group>
      </b-form-group>
    </b-modal>
  </div>
</div>
</template>
<script>
import NavBar from './NavBar.vue'
import Vue from 'vue'
import axios from 'axios'
export default {
  components: {
    NavBar
  },
  data() {
    return {
      rooms: [],
      name: '',
      breadcrumb: [{
        text: 'チャットルーム一覧',
        active: true
      }],
      feedbacks: []
    }
  },
  beforeCreate() {
    document.body.className = 'dashboard';
  },
  mounted() {
    this.getRooms();
  },
  computed: {
    states() {
      return {
        name: this.getState('name')
      }
    }
  },
  methods: {
    onUpload(progressEvent) {
      // TODO Refactor
      Vue.set(this.feedbacks, 'info', '通信中')
    },
    onError(error) {
      // Disable an alert of info
      Vue.delete(this.feedbacks, 'info')
      // TCP Errors
      if (error.response === undefined) {
        Vue.set(this.feedbacks, 'error', error.message);
        return;
      }
      // HTTP Response does not have contents
      if (error.response.data === undefined) {
        Vue.set(this.feedbacks, 'error', error.response.statusText);
        return;
      }
      // HTTP Response has JSON with errors
      if (error.response.data !== undefined) {
        // Cleanup feedbacks
        Object.keys(this.feedbacks).forEach((key) => {
          Vue.delete(this.feedbacks, key)
        })
        // Set errors to fedbacks
        Object.keys(error.response.data).forEach((key) => {
          var messages = error.response.data[key]
          var tkey = `room.${key}`
          messages.forEach((message) => {
            Vue.set(this.feedbacks, key, `${this.$t(tkey)}${message}`)
          })
        })
        return;
      }
      Vue.set(this.feedbacks, 'error', `Error: ${error.message}`)
    },

    getState(key) {
      if (this.feedbacks[key] === undefined) {
        return 'valid';
      } else {
        return 'invalid';
      }
    },
    getRooms() {
      let vm = this;
      axios({
        url: '/api/rooms',
        method: 'get'
      }).then(function(response) {
        vm.rooms = response.data;
      }).catch(function(error) {
        vm.feedbacks = []
        vm.feedbacks.push(error.response.statusText)
      })
    },
    createRoom(e) {
      e.preventDefault();
      let vm = this;
      let form = new FormData();
      form.set('room[name]', this.name);
      axios({
        url: '/api/rooms',
        method: 'post',
        headers: {
          'content-type': 'multipart/form-data'
        },
        data: form,
        onUploadProgress: this.onUpload()
      }).then(function(response) {
        let room = response.data
        vm.rooms.unshift(room)
        vm.name = ''
        vm.$refs.new_room.hide();
      }).catch(vm.onError)
    },
    clearFeedbacks() {
      Object.keys(this.feedbacks).forEach((key) => {
        Vue.delete(this.feedbacks, key)
      })
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
body.dashboard {
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
    // table {
    //   td {
    //     padding: 0;
    //     a {
    //       display: block;
    //       width: 100%;
    //       height: 100%;
    //       padding: 12px;
    //       &:hover {
    //         text-decoration: none;
    //       }
    //     }
    //   }
    // }
}
</style>
