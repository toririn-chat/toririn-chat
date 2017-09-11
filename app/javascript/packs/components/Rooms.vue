<template>
<div>
  <nav-bar></nav-bar>
  <div class="container">
    <b-breadcrumb class="mt-3" :items="[{text:'チャットルーム',href:'/rooms',active:true}]" />
    <div class="tc-theme-light">
      <b-button variant="primary" v-b-modal.new_room>
        新規作成
      </b-button>
    </div>
    <table class="table table-hover mt-3">
      <tbody>
        <tr v-for="room in rooms">
          <td>{{room.name}}</td>
        </tr>
      </tbody>
    </table>
  </div>
  <div class="tc-theme-light">
    <b-modal id="new_room" ref="new_room" size="sm" title="新規作成" ok-title="送信" close-title="キャンセル" no-auto-focus @ok="createRoom" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
      <b-alert variant="info" :show="feedbacks['info'] !== undefined">
        <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
        <span>{{feedbacks['info']}}</span>
      </b-alert>
      <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
        {{feedbacks['error']}}
      </b-alert>
      <b-form-group label="チャットルーム名" :feedback="feedbacks['name']" :state="states['name']">
        <b-input-group>
          <b-form-input type="text" v-model="name"></b-form-input>
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
  beforeCreate: function() {
    document.body.className = 'dashboard';
  },
  components: {
    NavBar
  },
  data() {
    return {
      rooms: [],
      name: '',
      feedbacks: []
    }
  },
  mounted: function() {
    this.getRooms()
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
      var vm = this;
      axios
        .get('/api/v2/rooms')
        .then(function(response) {
          vm.rooms = response.data;
        })
        .catch(function(error) {
          vm.feedbacks = []
          vm.feedbacks.push(error.response.statusText)
        })
    },
    createRoom(e) {
      e.cancel();
      var form = new FormData();
      form.append('room[name]', this.name);
      var config = {
        headers: {
          'content-type': 'multipart/form-data'
        },
        onUploadProgress: this.onUpload()
      };
      var vm = this;
      axios
        .post('/api/v2/rooms', form, config)
        .then(function(response) {
          var room = response.data
          vm.rooms.unshift(room)
          vm.name = ''
          vm.$refs.new_room.hide();
        })
        .catch(vm.onError)
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
}
</style>
