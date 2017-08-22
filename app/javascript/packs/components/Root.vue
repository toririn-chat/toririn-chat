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
      <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
        {{feedbacks['error']}}
      </b-alert>
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
    <b-modal id="signin" ref="signin" size="sm" title="ログイン" ok-title="ログイン" close-title="キャンセル" no-auto-focus @ok="signin">
      <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
        {{feedbacks['error']}}
      </b-alert>
      <b-form-group label="電子メールアドレス">
        <b-input-group>
          <b-form-input type="email" v-model="email"></b-form-input>
        </b-input-group>
      </b-form-group>
      <b-form-group label="パスワード">
        <b-input-group>
          <b-form-input type="password" v-model="password"></b-form-input>
        </b-input-group>
      </b-form-group>
      <div class="text-right mb-1">
        <b-btn size="sm" variant="light" @click="switchSigninToReconfirmation">
          <span>新規登録用URLの再送付</span>
          <i class="fa fa-chevron-right"></i>
        </b-btn>
      </div>
      <div class="text-right">
        <b-btn size="sm" variant="light" @click="switchSigninToReminder">
          <span>パスワードを忘れた場合</span>
          <i class="fa fa-chevron-right"></i>
        </b-btn>
      </div>
    </b-modal>
    <b-modal id="reconfirmation" ref="reconfirmation" size="sm" title="新規登録用URLの再送付" ok-title="送信" close-title="キャンセル" no-auto-focus @ok="reconfirmation">
      <p>新規登録用URLを再送付するには登録した電子メールアドレスを入力して送信ボタンを押してください。新規登録用URLを再送信します。</p>
      <b-form-group label="電子メールアドレス" description="登録した電子メールアドレスを入力してください。 " :feedback="feedbacks['email']" :state="states['email']">
        <b-input-group>
          <b-form-input type="email" v-model="email"></b-form-input>
        </b-input-group>
      </b-form-group>
    </b-modal>
    <b-modal id="reminder" ref="reminder" size="sm" title="パスワードを忘れた場合" ok-title="送信" close-title="キャンセル" no-auto-focus @ok="resetpassword">
      <p>パスワードを再設定するには登録した電子メールアドレスを入力して送信ボタンを押してください。パスワードを再設定するためのURLを送信します。</p>
      <b-form-group label="電子メールアドレス" description="登録した電子メールアドレスを入力してください。">
        <b-input-group>
          <b-form-input type="email" v-model="email"></b-form-input>
        </b-input-group>
      </b-form-group>
    </b-modal>
    <b-modal id="resetPasswordModal" ref="resetPasswordModal" size="sm" title="パスワードのリセット" ok-title="送信" close-title="キャンセル" no-auto-focus @ok="savePassword">
      <b-alert variant="danger" :show="feedbacks['reset_password_token'] !== undefined">
        {{feedbacks['reset_password_token']}}
      </b-alert>
      <p>新しいパスワードを設定してください。</p>
      <b-form-group label="パスワード" description="半角で8文字以上の長さにしてください。" :feedback="feedbacks['password']" :state="states['password']">
        <b-input-group>
          <b-form-input type="password" v-model="password"></b-form-input>
        </b-input-group>
      </b-form-group>
    </b-modal>
    <b-modal ref="confirmation" size="sm" title="新規登録用URLの送付" ok-only>
      <p>{{email}}に新規登録用のURLを送付しました。メールをご確認ください。</p>
    </b-modal>
    <b-modal ref="notifyPasswordReminder" size="sm" title="パスワードリセット用URLの送付" ok-only>
      <p>{{email}}にパスワードリセット用のURLを送付しました。メールをご確認ください。</p>
    </b-modal>
    <b-modal ref="finished" size="sm" title="お知らせ" ok-only @ok="redirectToRoot">
      <p>新規登録が完了しました。ログインしてください。</p>
    </b-modal>
    <b-modal ref="confirmed" size="sm" title="お知らせ" ok-only @ok="redirectToRoot">
      <p>既に新規登録は完了しています。ログインしてください。</p>
    </b-modal>
    <b-modal ref="finishSavePassword" size="sm" title="パスワードの変更完了" ok-only @ok="redirectToRoot">
      <p>パスワードの変更が完了しました。ログインしてください。</p>
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
  beforeCreate: function() {
    document.body.className = 'root';
  },
  mounted() {
    var confirmation_token = this.$route.query.confirmation_token;
    if (confirmation_token !== undefined) {
      var vm = this;
      var form = new FormData();
      form.append('user[confirmation_token]', confirmation_token);
      var config = {
        headers: {
          'content-type': 'multipart/form-data',
        }
      };
      axios
        .get('/api/v2/confirmations', {
          params: {
            confirmation_token: confirmation_token
          }
        }, config)
        .then(function(response) {
          vm.$refs.finished.show();
        })
        .catch(function(error) {
          vm.$refs.confirmed.show();
        })
    }
    // パスワードのリセット
    var reset_password_token = this.$route.query.reset_password_token;
    if (reset_password_token !== undefined) {
      var vm = this;
      axios
        .get('/api/v2/passwords', {
          params: {
            reset_password_token: reset_password_token
          }
        }, config)
        .then(function(response) {
          vm.$refs.resetPasswordModal.show();
          // TODO パスワード変更ダイアログ

          console.log(response);
          // vm.$refs.finished.show();
        })
        .catch(function(error) {
          console.log(error.response);
          // vm.$refs.confirmed.show();
        })
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
    handleError(error) {
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
      // HTTP Response has JSON with an error
      if (error.response.data.error !== undefined) {
        return;
      }
      // HTTP Response has JSON with errors
      if (error.response.data.errors !== undefined) {
        // cleanup feedbacks
        Object.keys(this.feedbacks).forEach((key) => {
          Vue.delete(this.feedbacks, key)
        })
        // set errors to fedbacks
        Object.keys(error.response.data.errors).forEach((key) => {
          var messages = error.response.data.errors[key]
          messages.forEach((message) => {
            Vue.set(this.feedbacks, key, `${this.$t(key)}${message}`)
          })
        })
        return;
      }
      console.log('www');
      console.log(error.message);
      Vue.delete(this.feedbacks, 'error')
      Vue.set(this.feedbacks, 'error', `Error: ${error.message}`)
    },
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
          vm.handleError(error);
        })
    },
    signin(e) {
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
        .post('/api/v2/signin', form, config)
        .then(function(response) {
          vm.$router.push({
            name: 'dashboard'
          });
        })
        .catch(function(error) {
          vm.handleError(error);
        })
    },
    reconfirmation(e) {
      e.cancel();
      var form = new FormData();
      form.append('user[email]', this.email);
      var config = {
        headers: {
          'content-type': 'multipart/form-data',
        }
      };
      var vm = this;
      axios
        .post('/api/v2/confirmations', form, config)
        .then(function(response) {
          vm.$refs.reconfirmation.hide();
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
    resetpassword(e) {
      e.cancel();
      var form = new FormData();
      form.append('user[email]', this.email);
      var config = {
        headers: {
          'content-type': 'multipart/form-data',
        }
      };
      var vm = this;
      axios
        .post('/api/v2/passwords', form, config)
        .then(function(response) {
          vm.$refs.reminder.hide();
          vm.$refs.notifyPasswordReminder.show();
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
    savePassword(e) {
      e.cancel();
      var form = new FormData();
      form.append('user[password]', this.password);
      console.log(this.$route.query.reset_password_token);
      form.append('user[reset_password_token]', this.$route.query.reset_password_token);
      var config = {
        headers: {
          'content-type': 'multipart/form-data',
        }
      };
      var vm = this;
      axios
        .put('/api/v2/passwords', form, config)
        .then(function(response) {
          vm.$refs.resetPasswordModal.hide()
          vm.$refs.finishSavePassword.show();
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
              if (key === 'reset_password_token') {
                Vue.set(vm.feedbacks, key, 'このURLは既に使用されたか期限切れです。パスワードリセットするにはパスワードを再設定するためのURLの送信手続きを再度実施してください。')
              } else {
                Vue.set(vm.feedbacks, key, `${vm.$t(key)}${message}`)
              }
            })
          })

        })
    },
    redirectToRoot() {
      this.$router.push({
        name: 'root'
      });
    },
    switchSigninToReconfirmation() {
      this.$refs.signin.hide();
      this.$refs.reconfirmation.show();
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
html {
    height: 100%;
    width: 100%;
    overflow: hidden;
}
body.root {
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
