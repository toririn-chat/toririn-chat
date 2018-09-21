<template>
<div class="tc-chat-root">
  <div class="d-flex flex-column justify-content-center align-items-center">
    <div>
      <h1 class="my-3">とりりん<i class="fa fa-star"></i>チャット</h1>
    </div>
    <div>
      <p>
        <b-btn variant="light" v-b-modal.signup>
          <span>はじめる</span>
        </b-btn>
      </p>
    </div>
  </div>
  <b-modal id="signup" ref="signup" size="sm" title="暗証番号" ok-title="送信" cancel-title="キャンセル" auto-focus @ok="signup" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
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
    onFeedbacksErrors(error) {
      console.log(error);
      // Disable an alert of info
      Vue.delete(this.feedbacks, 'info');
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

var api = {
  signin() {
    // var form = new FormData();
    // form.append('auth[password]', this.password);
    // var config = {
    //   headers: {
    //     'content-type': 'multipart/form-data',
    //   },
    //   onUploadProgress: this.onUpload()
    // };
    return axios
      .post('/api/v1/people/signin', {
        password: 'aaa'
      }, {
        headers: {
          'Accept': 'application/json'
        }
      })
    // .post('/api/v1/people/signin', form, config)
    // .then(function(response) {
    //   console.log(response);
    // })
    // .catch(function(error) {
    //   console.log(error);
    // })
  }
}

export default {
  mixins: [feedbacks],
  beforeCreate() {
    document.body.className = 'tc-chat-root';
  },
  data() {
    return {
      code: '',
      feedbacks: {}
    }
  },
  methods: {
    signup(evt) {
      var vm = this;
      evt.preventDefault();
      api.signin().then((response) => {
        console.log(response);
      }).catch(vm.onFeedbacksErrors)
      // console.log('ww');
      // Vue.set(this.feedbacks, 'code', 'aaa')
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
