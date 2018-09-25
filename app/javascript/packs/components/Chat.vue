<template>
<div>
  <b-navbar toggleable fixed="top" sticky class="tc-chat-header navbar-dark">
    <b-navbar-brand>{{ room.name }}</b-navbar-brand>
    <b-nav-toggle target="tc-nav-collapse" />
    <b-collapse is-nav id="tc-nav-collapse">
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
  <div class="container tc-chat-messages">
    <b-media v-for="message in room.messages" :key="message.id">
      <b-img width="64" height="64" slot="aside" :src="message.person.avatar.image_url" />
      <p>
        <strong>{{ message.person.name }}</strong>
        <span>{{ message.created_at }}</span>
      </p>
      <p v-show="message.text">{{ message.text }}</p>
      <b-img width="150" height="150" blank-width="150" blank-height="150" blank-color="#fbfbfb" :src="message.sticker_image_url" v-show="message.sticker_image_url" />
    </b-media>
  </div>
  <footer class="fixed-bottom tc-chat-footer">
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
  <!-- Profile -->
  <b-modal id="profile" ref="profile" size="sm" title="プロフィール設定" ok-title="OK" ok-only no-close-on-backdrop no-close-on-esc hide-header-close @ok="saveProfile" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
    <b-alert variant="info" :show="feedbacks['info'] !== undefined">
      <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
      <span>{{ feedbacks['info'] }}</span>
    </b-alert>
    <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
      <span>{{ feedbacks['error'] }}</span>
    </b-alert>
    <b-form-group label="名前" label-class="font-weight-bold" :feedback="feedbacks['name']" :state="states['name']">
      <b-input-group>
        <b-form-input type="text" v-model="person.name" autocomplete="off" />
      </b-input-group>
    </b-form-group>
    <b-form-group label="アイコン" label-class="font-weight-bold" :feedback="feedbacks['avatars']" :state="states['avatars']">
      <div class="gallery">
        <div class="container">
          <div class="row">
            <div class="col col-sm-3" v-for="avatar in personAvatars">
              <b-img rounded fluid-grow :src="avatar.image_url" :alt="avatar.name" v-bind:class="{ active: avatar.is_active, inactive: !avatar.is_active }" @click="selectPersonAvatar(avatar)" />
            </div>
          </div>
        </div>
      </div>
    </b-form-group>
  </b-modal>
  <!-- Signin -->
  <b-modal id="signin" ref="signin" size="sm" title="ログイン" ok-title="ログイン" ok-only no-close-on-backdrop no-close-on-esc hide-header-close @ok="signin" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
    <b-alert variant="info" :show="feedbacks['info'] !== undefined">
      <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
      <span>{{ feedbacks['info'] }}</span>
    </b-alert>
    <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
      <span>{{ feedbacks['error'] }}</span>
    </b-alert>
    <b-form-group label="暗証番号" :feedback="feedbacks['chat_code']" :state="states['chat_code']">
      <b-input-group>
        <b-form-input type="password" v-model="person.session.chat_code" />
      </b-input-group>
    </b-form-group>
  </b-modal>
</div>
</template>
<script>
import Vue from 'vue'
import axios from 'axios'
import feedbacks from '../plugins/feedbacks'

export default {
  mixins: [feedbacks],
  data() {
    return {
      person: {
        session: {
          exists: false,
          chat_code: '',
        },
        name: '',
        avatar: {
          id: '',
          image_url: ''
        },
        avatars: []
      },
      room: {
        name: '',
        messages: []
      },
      message: {
        text: '',
        sticker: {
          id: ''
        }
      }
    };
  },
  computed: {
    personAvatars() {
      let vm = this;
      let avatars = vm.person.avatars;
      if (avatars.length === 0) {
        return [];
      } else {
        if (vm.person.avatar.image_url.length === 0) {
          // reset the status of avatars
          avatars.forEach(function(avatar) {
            Vue.set(avatar, 'is_active', false);
          });
          // sample a avatar randomly
          let avatar = avatars[Math.floor(Math.random() * avatars.length) + 1];
          Vue.set(avatar, 'is_active', true);
          Vue.set(vm.person, 'avatar', avatar);
        }
        return avatars;
      }
    },
    messageDisabled() {
      if (this.message.text === '') {
        return true;
      } else {
        return false;
      }
    }
  },
  beforeCreate() {
    document.body.className = 'chat';
  },
  mounted() {
    this.checkSession();
    // this.getAvatars();
    // this.getChatRoom();
    // this.getProfile();
    // this.getMessages();
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
        // a person has session
        Vue.set(vm.person.session, 'exists', true);
        vm.$refs.profile.show();
        vm.getPersonAvatars();

        // TODO
        // console.log('has session');
        // load chat data when a person has session
        // this.getChatData();
        // ログイン指定ないくてもavatarsは取れる必要がある。
        // ログインしてれば
        //   プロフィール情報を取得する。
        //   プロフィールの情報がからなら、ダイアログを表示する。
        //   チャットの内容を取得する。
        // ログインしていなければ
        // 　暗証番号のダイアログを表示する
      }).catch(function(error) {
        // a person has no session
        vm.$refs.signin.show();
      })
    },
    signin(e) {
      e.preventDefault();
      let vm = this;
      let form = new FormData();
      form.set('chat_code', this.person.session.chat_code);
      axios({
        url: `/api/chats/${vm.$route.params.id}/signin`,
        method: 'post',
        data: form,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
        onUploadProgress: this.onFeedbacksProgress
      }).then((response) => {
        Vue.set(vm.person.session, 'exists', true);
        vm.$refs.profile.show();
        vm.getPersonAvatars();
      }).catch(vm.onFeedbacksErrors)
    },
    getPerson() {
      let vm = this;
      axios({
        url: `/api/chats/${vm.$route.params.id}/person`,
        method: 'get'
      }).then(function(response) {
        let person = response.data;
        vm.person.name = person.name;
      }).catch(vm.onFeedbacksErrors)
    },
    getPersonAvatars() {
      let vm = this;
      axios({
        url: `/api/chats/${vm.$route.params.id}/avatars`,
        method: 'get'
      }).then(function(response) {
        vm.person.avatars = response.data;
      }).catch(vm.onFeedbacksErrors)
    },
    getChatData() {
      console.log('test');
    },
    getChatRoom() {
      let vm = this;
      axios({
        url: `/api/chats/${vm.$route.params.id}/room`,
        method: 'get'
      }).then(function(response) {
      vm.room = response.data;
      Vue.nextTick(function() {
        window.scrollTo(0, document.body.scrollHeight);
      })
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
        vm.room.messages = [];
        response.data.forEach((message) => {
          vm.room.messages.push(message)
        })
        Vue.nextTick(function() {
          window.scrollTo(0, document.body.scrollHeight);
        })
      }).catch(function(error) {
        // TODO error handling
        console.log(error);
      })
    },
    selectPersonAvatar(avatar) {
      let vm = this;
      vm.person.avatars.forEach(function(avatar) {
        Vue.set(avatar, 'is_active', false);
      });
      Vue.set(avatar, 'is_active', true);
      Vue.set(vm.person, 'avatar', avatar);
    },
    saveProfile(e) {
      e.preventDefault();
      let vm = this;
      let form = new FormData();
      form.set('name', vm.person.name);
      form.set('avatar_id', vm.person.avatar.id);
      axios({
        resource: 'person',
        url: `/api/chats/${vm.$route.params.id}/person`,
        method: 'patch',
        data: form,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
        onUploadProgress: this.onFeedbacksProgress
      }).then(function(response) {
        vm.$refs.profile.hide();
        vm.getChatRoom();
      }).catch(vm.onFeedbacksErrors)
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
    },
    test123() {
      console.log('test123');
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
.tc-chat-header {
  background-color: rgba(#3d4070, 0.95) !important;
  .navbar-brand {
    color: rgba(#eeeeee, 0.95) !important;
  }
  .nav-link {
    color: rgba(#eeeeee, 0.95) !important;
  }
  .nnavbar-toggler {
    color: rgba(#eeeeee, 0.95) !important;
  }
}
.tc-chat-messages {
  padding-top: 15px;
  padding-bottom: 15px;
  margin-bottom: 52px;
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
div.gallery {
  .container {
    padding-left: 0;
    padding-right: 0;
  }
  .col {
    padding-left: 0;
    padding-right: 0;
  }
  .col:nth-child(4n+1) {
    clear: both;
  }
  img {
    cursor: pointer;
    display: inline;
  }
}
.inactive {
  opacity: 0.2;
}
.active {
  opacity: 1.0;
}
</style>
