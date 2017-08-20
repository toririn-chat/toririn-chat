<template>
<div class="tc-splash">
  <div class="container">
    <div class="row justify-content-center mb-3">
      <div class="col-5 col-sm-3 text-center">
        <img class="img-fluid" src="images/logo.png"></img>
      </div>
    </div>
    <div class="row justify-content-center mb-3">
      <div class="text-center">
        <h1>とりりん<i class="fa fa-star"></i>チャット</h1>
      </div>
    </div>
    <div class="row justify-content-center d-none d-sm-none d-md-flex mb-3">
      <div class="col-4">
        <div class="tc-theme-dark">
          <b-btn variant="primary" block v-b-modal.signup>
            <span>新規登録</span>
          </b-btn>
        </div>
      </div>
    </div>
    <div class="row justify-content-center d-none d-sm-none d-md-flex mb-3">
      <div class="col-4">
        <div class="tc-theme-dark">
          <b-btn variant="primary" block v-b-modal.signin>
            <span>ログイン</span>
          </b-btn>
        </div>
      </div>
    </div>
  </div>
  <div class="container fixed-bottom d-md-none">
    <div class="row justify-content-center mb-3">
      <div class="col-12">
        <div class="tc-theme-dark">
          <b-btn variant="primary" block v-b-modal.signup>
            <span>新規登録</span>
          </b-btn>
        </div>
      </div>
    </div>
    <div class="row justify-content-center mb-3">
      <div class="col-12">
        <div class="tc-theme-dark">
          <b-btn variant="primary" block v-b-modal.signin>
            <span>ログイン</span>
          </b-btn>
        </div>
      </div>
    </div>
  </div>
  <div class="tc-theme-light">
    <b-modal id="signup" ref="signup" size="sm" title="新規登録" ok-title="新規登録" close-title="キャンセル" no-auto-focus @ok="signup">
      <b-form-group label="電子メールアドレス" description="入力した電子メールアドレスに新規登録用のURLを送信します。" :feedback="feedbacks['email']" :state="states['email']">
        <b-input-group>
          <b-form-input type="email" v-model="email"></b-form-input>
        </b-input-group>
      </b-form-group>
      <b-form-group label="パスワード" description="半角で8文字以上の長さにしてください。" :feedback="feedbacks['password']" :state="states['password']">
        <b-input-group>
          <b-form-input type="password" v-model="password"></b-form-input>
        </b-input-group>
      </b-form-group>
    </b-modal>
    <b-modal id="signin" ref="signin" size="sm" title="ログイン" ok-title="ログイン" close-title="キャンセル" no-auto-focus>
      <b-form-group label="電子メールアドレス" description="登録した電子メールアドレスを入力してください。" :feedback="feedbacks['email']">
        <b-input-group>
          <b-form-input type="email"></b-form-input>
        </b-input-group>
      </b-form-group>
      <b-form-group label="パスワード" description="登録したパスワードを入力してください。">
        <b-input-group>
          <b-form-input type="password"></b-form-input>
        </b-input-group>
      </b-form-group>
      <div class="text-right">
        <b-btn variant="light" @click="switchSigninToReminder">
          <span>パスワードを忘れた場合</span>
          <i class="fa fa-chevron-right"></i>
        </b-btn>
      </div>
    </b-modal>
    <b-modal id="reminder" ref="reminder" size="sm" title="パスワードを忘れた場合" ok-title="送信" close-title="キャンセル" no-auto-focus>
      <p>パスワードを再設定するには登録した電子メールアドレスを入力して送信ボタンを押してください。パスワードを再設定するためのURLを送信します。</p>
      <b-form-group label="電子メールアドレス" description="登録した電子メールアドレスを入力してください。">
        <b-input-group>
          <b-form-input type="email"></b-form-input>
        </b-input-group>
      </b-form-group>
    </b-modal>
    <b-modal id="confirmation" ref="confirmation" size="sm" title="新規登録用URLの送付" ok-only>
      <p>{{email}}に新規登録用のURLを送付しました。メールをご確認ください。</p>
    </b-modal>
  </div>
</div>
</template>
<script>
import Vue from 'vue'
import axios from 'axios'

export default {
  data: function() {
    // TODO remove test date
    return {
      email: "u11@example.net",
      password: "11111111",
      feedbacks: {},
    }
  },
  computed: {
    states() {
      return {
        email: this.state('email'),
        password: this.state('password')
      }
    }
  },
  methods: {
    state(key) {
      if (this.feedbacks[key] === undefined) {
        return 'valid';
      } else {
        return 'invalid';
      }
    },
    signup(e) {
      e.cancel();
      var form = new FormData();
      form.append('user[email]', this.email);
      form.append('user[password]', this.password);
      var config = {
        headers: {
          'content-type': 'multipart/form-data',
        }
      };
      var vm = this;
      axios
        .post('/api/v2/signup', form, config)
        .then(function(response) {
          vm.$refs.signup.hide();
          vm.$refs.confirmation.show();
        })
        .catch(function(error) {
          // cleanup feedbacks
          Object.keys(vm.feedbacks).forEach((key) => {
            Vue.delete(vm.feedbacks, key)
          })
          // set errors to fedbacks
          var errors = error.response.data.errors
          Object.keys(errors).forEach((key) => {
            var messages = errors[key]
            messages.forEach((message) => {
              Vue.set(vm.feedbacks, key, `${vm.$t(key)}${message}`)
            })
          })
        })
    },
    switchSigninToReminder() {
      this.$refs.signin.hide();
      this.$refs.reminder.show();
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
body,
html {
    background-color: $tc-color-dark;
    height: 100%;
    width: 100%;
    overflow: hidden;
}
div.tc-splash {
    height: 100%;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: $tc-color-dark;
    h1 {
        font-size: 32px;
        color: $tc-color-light;
    }
}
div.tc-theme-dark {
    button.btn-primary {
        border-radius: 0.25rem;
        border: 0 none;
        color: $tc-color-dark;
        background-color: $tc-color-light;
        &:hover {
            color: lighten($tc-color-dark, 15%);
            background-color: lighten($tc-color-light, 30%);
        }
    }
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
