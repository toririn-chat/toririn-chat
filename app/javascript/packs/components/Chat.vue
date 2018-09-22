<template>
<div>
  <b-navbar toggleable fixed="top" sticky class="tc-chat-header">
    <b-navbar-brand>{{ room.name }}</b-navbar-brand>
    <b-nav-toggle target="nav_collapse" />
    <b-collapse is-nav id="nav_collapse">
      <b-navbar-nav class="ml-auto">
        <b-nav-item-dropdown text="<i class='fa fa-user'></i>&nbsp;<span>アカウント</span>" right>
          <b-dropdown-item v-b-modal.profile>
            <i class="fa fa-gear"></i>
            <span>設定</span>
          </b-dropdown-item>
          <b-dropdown-divider/>
          <b-dropdown-item @click="signout">
            <i class="fa fa-sign-out"></i>
            <span>ログアウト</span>
          </b-dropdown-item>
        </b-nav-item-dropdown>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
  <div class="container">
    <b-media v-for="message in messages" :key="message.id">
      <b-img width="64" height="64" slot="aside" :src="message.person_avatar_image_url" />
      <p>{{ message.person_name }} {{ message.created_at }}</p>
      <p v-show="message.text">{{message.text}}</p>
      <b-img width="150" height="150" blank-width="150" blank-height="150" blank-color="#fbfbfb" :src="message.sticker_image_url" v-show="message.sticker_image_url" />
    </b-media>
  </div>
  <footer class="fixed-bottom sticky-top tc-chat-footer">
    <b-input-group class="p-1">
      <b-input-group-prepend>
        <b-btn size="lg">
          <i class="fa fa-lg fa-smile-o"></i>
        </b-btn>
      </b-input-group-prepend>
      <b-form-input size="lg" type="text" placeholder="メッセージを入力" v-model="message.text" />
      <b-input-group-append>
        <b-btn size="lg" :disabled="messageDisabled" @click="sendText">
          <i class="fa fa-lg fa-paper-plane-o"></i>
        </b-btn>
      </b-input-group-append>
    </b-input-group>
  </footer>
</div>
</template>
<script>
import Vue from 'vue'
import axios from 'axios'
export default {
  data() {
    return {
      message: {
        text: '',
        sticker: {
          id: ''
        },
      },
      messages: [],
      room: {
        id: '',
        name: '',
        token: '',
        updated_at: '',
        created_at: '',
      },
      person: {
        id: '',
        name: 'テスト',
        avatar_image_url: 'http://localhost:3000/api/chats/VdpzdnBgY2l1NvpmYrgY/avatars/69380186'
      }
    };
  },
  computed: {
    messageDisabled() {
      if (this.message.text === '') {
        return true;
      } else {
        return false;
      }
    },
  },
  beforeCreate() {
    document.body.className = 'chat';
  },
  mounted() {
    this.checkSession();
    this.getChatRoom();
    this.getProfile();
    this.getMessages();
  },
  methods: {
    checkSession() {
      let vm = this;
      axios({
        url: `/api/chats/${vm.$route.params.id}/signin`,
        method: 'get',
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        }
      }).then((response) => {
        // do nothing
      }).catch(function(error) {
        vm.$router.push({
          name: 'chat_signin'
        });
      })
    },
    getChatRoom() {
      let vm = this;
      axios({
        url: `/api/chats/${vm.$route.params.id}/room`,
        method: 'get'
      }).then(function(response) {
          vm.room = response.data;
      }).catch(function(error) {
        // TODO error handling
        console.log(response.error);
      })
    },
    getMessages() {
      let vm = this;
      axios({
        url: `/api/chats/${vm.$route.params.id}/messages`,
        method: 'get'
      }).then(function(response) {
        vm.messages = [];
        response.data.forEach((message) => {
          vm.messages.push(message)
        })
        Vue.nextTick(function() {
          window.scrollTo(0, document.body.scrollHeight);
        })
      }).catch(function(error) {
        // TODO error handling
        console.log(error);
      })
    },
    getProfile() {
    },
    sendText() {
      // TODO implement
      console.log(this.message.text);
      // // this.getMessages()
      //
      // console.log(this.message.text);
      //       var vm = this;
      //       var form = new FormData();
      //       form.append('message[text]', this.message.text);
      //
      // // /api/v2/rooms/351937511/messages.json
      //       axios
      //         .post(`/api/v2/rooms/${vm.$route.params.id}/messages.json`)
      //         .then(function(response) {
      //           console.log(response);
      //           // vm.messages = response.data;
      //         })
      //         .catch(function(error) {
      //           // TODO error handling
      //           console.log(response.error);
      //         })
    },
    signout() {
      console.log('signout');
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
.tc-chat-header {
  background-color: rgba(#3d4070, 0.95);
  .navbar-brand {
    color: rgba(#eeeeee, 0.95) !important;
  }
  .nav-link {
    color: rgba(#eeeeee, 0.95) !important;
  }
}
.tc-chat-footer {
  background-color: rgba(#F7F8FC, 0.95);
  button.disabled {
    color: #f0f0f0;
    background-color: rgba(#FFFFFF, 0.0);
    &:hover {
      color: #f0f0f0;
      background-color: rgba(#FFFFFF, 0.0);
    }
  }
  button {
    border: 0 none;
    border-radius: 0;
    color: #000000;
    background-color: rgba(#FFFFFF, 0.0);
    &:hover {
      color: #000000;
      background-color: darken(rgba(#F7F8FC, 0.95), 5%);
    }
  }
  input {
    border: 0 none;
    background-color: rgba(#FFFFFF,0.0);
    &:focus {
      background-color: rgba(#FFFFFF,0.0);
    }
  }
}
</style>
