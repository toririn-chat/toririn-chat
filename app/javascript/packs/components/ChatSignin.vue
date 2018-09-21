<template>
<div class="tc-chat-root">
  <div class="d-flex flex-column justify-content-center align-items-center">
    <div>
      <h1 class="my-3">とりりん<i class="fa fa-star"></i>チャット</h1>
    </div>
    <div>
      <p>
        <b-btn variant="light" v-b-modal.signin>
          <span>はじめる</span>
        </b-btn>
      </p>
    </div>
  </div>
  <b-modal id="signin" ref="signin" size="sm" title="暗証番号" ok-title="送信" cancel-title="キャンセル" auto-focus @ok="signin" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
    <b-alert variant="info" :show="feedbacks['info'] !== undefined">
      <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
      <span>{{feedbacks['info']}}</span>
    </b-alert>
    <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
      {{feedbacks['error']}}
    </b-alert>
    <b-form-group :feedback="feedbacks['code']" :state="states['code']">
      <b-input-group>
        <b-form-input type="password" v-model="code"></b-form-input>
      </b-input-group>
    </b-form-group>
  </b-modal>
</div>
</template>
<script>
import Vue from 'vue'
import axios from 'axios'

var feedbacks = {
  methods: {
    getFeedbacksState(key) {
      if (this.feedbacks[key] === undefined) {
        return 'valid';
      } else {
        return 'invalid';
      }
    },
    clearFeedbacks() {
      Object.keys(this.feedbacks).forEach((key) => {
        Vue.delete(this.feedbacks, key);
      })
    },
    onUpload(progressEvent) {
      // TODO Refactor
      Vue.set(this.feedbacks, 'info', '通信中')
    },
    onFeedbacksErrors(error) {
      // Disable an alert of info
      Vue.delete(this.feedbacks, 'info');
      Vue.set(this.feedbacks, 'error', error.response.statusText);
      return;

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
        console.log(error.response);
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
    }
  },
  computed: {
    states() {
      var s = {};
      Object.keys(this.feedbacks).forEach((key) => {
        s[key] = this.getFeedbacksState(key)
      })
      return s;
    }
  }
}

export default {
  mixins: [feedbacks],
  data() {
    return {
      code: '',
      feedbacks: {}
    }
  },
  beforeCreate() {
    document.body.className = 'tc-chat-root';
  },
  methods: {
    signin(e) {
      e.preventDefault();
      let vm = this;
      let form = new FormData();
      form.set('chat_code', this.code);
      axios({
        url: `/api/chats/${vm.$route.params.id}/signin`,
        method: 'post',
        data: form,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
        onUploadProgress: this.onUpload()
      }).then((response) => {
        vm.$router.push({
          name: 'chat_config'
        });
      }).catch(vm.onFeedbacksErrors)
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
html {
    height: 100%;
    width: 100%;
    body.tc-chat-root {
        height: 100%;
        width: 100%;
        overflow: hidden;
        div.tc-chat-root {
            height: 100%;
            width: 100%;
            .d-flex {
                height: 100%;
            }
            h1 {
                font-size: 32px;
                color: $tc-color-light;
            }
            background-color: $tc-color-dark;
        }
    }
}
</style>
