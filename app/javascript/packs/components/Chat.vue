<template>
<div>
  <!-- Header -->
  <b-navbar toggleable fixed="top" sticky class="tc-chat-header navbar-dark">
    <b-navbar-brand>{{ room.name }}</b-navbar-brand>
    <b-navbar-nav class="ml-auto">
      <b-nav-item v-b-modal.profile>
        <i class="fa fa-gear"></i>
        <span>設定</span>
      </b-nav-item>
    </b-navbar-nav>
  </b-navbar>
  <!-- Messages -->
  <div class="container tc-chat-messages">
    <div class="row justify-content-center">
      <div class="col-xs-12 col-md-8 col-lg-8">
        <div v-for="message in room.messages" :key="message.id" :class="messageClass(message)">
          <img v-if="!messageOwnerIsMe(message)" :src="message.person.avatar.image_url" :alt="message.person.name" width="64" height="64" class="align-self-start mr-1">
          <div class="media-body">
            <p class="mb-1">
              <strong>{{ message.person.name }}</strong>
              <span>{{ message.created_at | moment }}</span>
            </p>
            <p v-if="messageTypeIsText(message)">{{ message.text }}</p>
            <img v-if="messageTypeIsSticker(message)" :src="message.sticker.image_url" width="150" height="150"   />
          </div>
          <img v-if="messageOwnerIsMe(message)" :src="message.person.avatar.image_url" :alt="message.person.name" width="64" height="64" class="align-self-start ml-1">
        </div>
      </div>
    </div>
  </div>
  <!-- Footer -->
  <footer class="fixed-bottom tc-chat-footer">
    <b-input-group class="p-1">
      <b-input-group-prepend>
        <b-btn size="lg" v-b-modal.stickers>
          <i class="fa fa-lg fa-smile-o"></i>
        </b-btn>
      </b-input-group-prepend>
      <b-form-input name="message" size="lg" type="text" placeholder="メッセージを入力" v-model="message.text" autocomplete="off" />
        <b-btn size="lg" :disabled="messageDisabled" @click="sendTextMessage">
          <i class="fa fa-lg fa-paper-plane-o"></i>
        </b-btn>
      </b-input-group-append>
    </b-input-group>
  </footer>
  <!-- Signin -->
  <b-modal id="signin" ref="signin" size="sm" title="ログイン" ok-title="ログイン" ok-only no-close-on-backdrop no-close-on-esc hide-header-close @ok="handleSignin" :visible="!session.exists" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
    <b-alert variant="info" :show="feedbacks['info'] !== undefined">
      <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
      <span>{{ feedbacks['info'] }}</span>
    </b-alert>
    <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
      <span>{{ feedbacks['error'] }}</span>
    </b-alert>
    <form autocomplete="off">
      <b-form-group label="暗証番号" :feedback="feedbacks['session.chat_code']" :state="states['session.chat_code']">
        <b-input-group>
          <b-form-input type="password" v-model="session.chat_code" />
        </b-input-group>
      </b-form-group>
    </form>
  </b-modal>
  <!-- Profile -->
  <b-modal id="profile" ref="profile" size="sm" title="設定" ok-title="OK" ok-only no-close-on-backdrop no-close-on-esc hide-header-close @ok="handleSaveProfile" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
    <b-alert variant="info" :show="feedbacks['info'] !== undefined">
      <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
      <span>{{ feedbacks['info'] }}</span>
    </b-alert>
    <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
      <span>{{ feedbacks['error'] }}</span>
    </b-alert>
    <b-form-group label="名前" label-class="font-weight-bold" :feedback="feedbacks['person.name']" :state="states['person.name']">
      <b-input-group>
        <b-form-input type="text" v-model="person.name" autocomplete="off" />
      </b-input-group>
    </b-form-group>
    <b-form-group label="アイコン" label-class="font-weight-bold" :feedback="feedbacks['person.avatar']" :state="states['person.avatar']">
      <div class="gallery">
        <div class="container">
          <div class="row">
            <div class="col col-3" v-for="avatar in avatars">
              <b-img rounded fluid-grow :src="avatar.image_url" :alt="avatar.name" v-bind:class="{ active: avatar.is_active, inactive: !avatar.is_active }" @click="selectPersonAvatar(avatar)" />
            </div>
          </div>
        </div>
      </div>
    </b-form-group>
  </b-modal>
  <!-- Stickers -->
  <b-modal id="stickers" ref="stickers" size="md" title="スタンプ" :hide-footer="true">
    <div class="gallery">
      <div class="container">
        <div class="row">
          <div class="col col-3" v-for="sticker in stickers">
            <b-img rounded fluid-grow :src="sticker.image_url" :alt="sticker.name"  @click="selectSticker(sticker)" />
          </div>
        </div>
      </div>
    </div>
  </b-modal>
</div>
</template>
<script>
import moment from 'moment'
import Vue from 'vue'
import axios from 'axios'
import ActionCable from 'actioncable';
import feedbacks from '../plugins/feedbacks'
export default {
  mixins: [feedbacks],
  data() {
    return {
      cable: null,
      channel: null,
      room: {
        name: '',
        messages: [],
        avatars: [],
        stickers: []
      },
      person: {
        name: '',
        avatar: {
          id: '',
          image_url: ''
        }
      },
      session: {
        token: '',
        code: '',
        exists: false
      },
      message: {
        text: ''
      }
    };
  },
  computed: {
    token() {
      return this.$route.params.id;
    },
    messageDisabled() {
      if (this.message.text === '') {
        return true;
      } else {
        return false;
      }
    },
    avatars() {
      let vm = this;
      if (vm.person.avatar.id !== undefined && vm.room.avatars.length > 0) {
        vm.room.avatars.forEach(function(avatar) {
          Vue.set(avatar, 'is_active', avatar.id === vm.person.avatar.id);
        });
      }
      return vm.room.avatars;
    },
    stickers() {
      let vm = this;
      return vm.room.stickers;
    }
  },
  watch: {
    'session.exists': function(value) {
      if(value === true) {
        this.getRoom();
        this.getPerson();
        this.connect();
      }
    }
  },
  filters: {
    moment(date) {
      moment.locale('ja');
      return moment(date).format('llll');
    }
  },
  methods: {
    getRoom() {
      let vm = this;
      axios({
        url: `/api/chats/${vm.token}/room`,
        method: 'get'
      }).then(function(response) {
        vm.room = response.data;
        vm.handleScroll();
      }).catch(vm.onFeedbacksErrors)
    },
    getPerson() {
      let vm = this;
      axios({
        url: `/api/chats/${vm.token}/person`,
        method: 'get'
      }).then(function(response) {
        vm.person = response.data;
        Vue.nextTick(function() {
          if(vm.person.name === '') {
            vm.$refs.profile.show();
          }
        });
      }).catch(vm.onFeedbacksErrors)
    },
    handleSignin(event) {
      event.preventDefault();
      let vm = this;
      let form = new FormData();
      form.set('chat_code', vm.session.chat_code);
      axios({
        resource: 'session',
        url: `/api/chats/${vm.$route.params.id}/signin`,
        method: 'post',
        data: form,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
        onUploadProgress: this.onFeedbacksProgress()
      }).then(function(response) {
        Vue.set(vm.session, 'exists', true);
      }).catch(vm.onFeedbacksErrors)
    },
    handleSaveProfile(event) {
      event.preventDefault();
      let vm = this;
      let form = new FormData();
      form.set('person[name]', vm.person.name);
      form.set('person[avatar_id]', vm.person.avatar.id);
      axios({
        resource: 'person',
        url: `/api/chats/${vm.$route.params.id}/person`,
        method: 'patch',
        data: form,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
        onUploadProgress: this.onFeedbacksProgress()
      }).then(function(response) {
        vm.$refs.profile.hide();
      }).catch(vm.onFeedbacksErrors)
    },
    handleScroll() {
      Vue.nextTick(function() {
        window.scrollTo(0, document.body.scrollHeight);
      });
    },
    selectPersonAvatar(avatar) {
      let vm = this;
      Vue.set(vm.person, 'avatar', avatar);
    },
    selectSticker(sticker) {
      let vm = this;
      let result = vm.channel.sticker(sticker.id);
      if(result) {
        vm.$refs.stickers.hide();
      } else {
        // TODO: show error message about sending message
      }
    },
    sendTextMessage() {
      let vm = this;
      let result = vm.channel.text(vm.message.text);
      if(result) {
        Vue.set(vm.message, 'text', '');
      } else {
        // TODO: show error message about sending message
      }
    },
    connect() {
      let vm = this;
      // Create Consumer
      vm.cable = ActionCable.createConsumer(`/cable?token=${vm.token}`);
      // Create Channel
      let identifier = { channel: 'ChatChannel', token: vm.token };
      let client = {
        connected() {
          // DEBUG:
          // console.log('connected');
        },
        disconnected() {
          // DEBUG:
          // console.log('disconnected');
        },
        received(data) {
          // DEBUG:
          // console.log('received', data);
          vm.room.messages.push(data.message);
          Vue.nextTick(function() {
            window.scrollTo(0, document.body.scrollHeight);
          });
        },
        text(text) {
          return this.perform('text', { text: text });
        },
        sticker(sticker_id) {
          return this.perform('sticker', { sticker_id: sticker_id });
        }
      };
      vm.channel = vm.cable.subscriptions.create(identifier, client);
    },
    messageClass (message) {
      return [
        'media',
        'mb-2',
        'tc-message',
        { 'tc-message-text': this.messageTypeIsText(message) },
        { 'tc-message-sticker': this.messageTypeIsSticker(message) },
        { 'tc-message-right': this.messageOwnerIsMe(message) },
        { 'tc-message-left': !this.messageOwnerIsMe(message) },
      ];
    },
    messageOwnerIsMe(message) {
      return message.person.id === this.person.id;
    },
    messageTypeIsText(message) {
      return message.type === 'text';
    },
    messageTypeIsSticker(message) {
      return message.type === 'sticker';
    }
  },
  beforeCreate() {
    document.body.className = 'chat';
  },
  mounted() {
   let vm = this;
    axios({
      url: `/api/chats/${vm.$route.params.id}/signin`,
      method: 'get'
    }).then(function(response) {
      Vue.set(vm.session, 'exists', true);
    }).catch(function(error) {
      Vue.set(vm.session, 'exists', false);
    });
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
  padding-bottom: 60px;
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

// messages

.media.tc-message.tc-message-text {
  .media-body {
    background: #d7ebfe;
    padding: 8px;
    border-radius: 12px;
    p {
      margin-bottom: 0;
    }
  }
}

.media.tc-message.tc-message-sticker {
  .media-body {
    padding: 8px;
  }
}

.media.tc-message-right {
  margin-left: 120px;
}
.media.tc-message-left {
  margin-right: 120px;
}

// .media.baloon {
//   .media-body {
//     background: #d7ebfe;
//     padding: 8px;
//     border-radius: 12px;
//     p {
//       margin-bottom: 0;
//     }
//   }
// }
// .media.baloon.your-message {
//   margin-left: 80px;
// }
// .media.baloon.others-message {
//   margin-right: 80px;
// }

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
