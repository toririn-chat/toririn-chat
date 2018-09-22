<template>
<div class="tc-chat-signin">
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
  <b-modal id="signin" ref="signin" size="sm" title="暗証番号" ok-title="ログイン" cancel-title="キャンセル" auto-focus @ok="signin" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
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
import feedbacks from '../plugins/feedbacks'
export default {
  mixins: [feedbacks],
  data() {
    return {
      code: ''
    };
  },
  beforeCreate() {
    document.body.className = 'tc-chat-signin';
  },
  mounted() {
    this.checkSession();
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
        onUploadProgress: this.onFeedbacksProgress
      }).then((response) => {
        vm.$router.push({
          name: 'chat'
        });
      }).catch(vm.onFeedbacksErrors)
    },
    checkSession() {
      let vm = this;
      axios({
        url: `/api/chats/${vm.$route.params.id}/signin`,
        method: 'get',
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
      }).then((response) => {
        vm.$router.push({
          name: 'chat'
        });
      }).catch(function(error) {
        // do nothing
      })
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
html {
  height: 100%;
  width: 100%;
  body.tc-chat-signin {
    height: 100%;
    width: 100%;
    overflow: hidden;
    div.tc-chat-signin {
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
