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
    <b-modal id="signup" ref="signup" size="sm" title="新規登録" ok-title="新規登録" close-title="キャンセル" no-auto-focus @ok="signup" @shown="clearFeedbacks" :ok-disabled="feedbacks['info'] !== undefined">
      <b-alert variant="info" :show="feedbacks['info'] !== undefined">
        <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
        <span>{{feedbacks['info']}}</span>
      </b-alert>
      <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
        {{feedbacks['error']}}
      </b-alert>
      <b-form-group label="電子メールアドレス" description="入力した電子メールアドレスに本人確認用のURLを送信します。" :feedback="feedbacks['email']" :state="states['email']">
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
    <b-modal id="signin" ref="signin" size="sm" title="ログイン" ok-title="ログイン" close-title="キャンセル" no-auto-focus @ok="signin" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
      <b-alert variant="info" :show="feedbacks['info'] !== undefined">
        <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
        <span>{{feedbacks['info']}}</span>
      </b-alert>
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
          <span>本人確認用URLの再送付</span>
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
    <b-modal id="reconfirmation" ref="reconfirmation" size="sm" title="本人確認用URLの再送付" ok-title="送信" close-title="キャンセル" no-auto-focus @ok="reconfirmation" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
      <b-alert variant="info" :show="feedbacks['info'] !== undefined">
        <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
        <span>{{feedbacks['info']}}</span>
      </b-alert>
      <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
        {{feedbacks['error']}}
      </b-alert>
      <p>本人確認用URLを再送付するには登録した電子メールアドレスを入力して送信ボタンを押してください。本人確認用URLを再送信します。</p>
      <b-form-group label="電子メールアドレス" description="登録した電子メールアドレスを入力してください。 " :feedback="feedbacks['email']" :state="states['email']">
        <b-input-group>
          <b-form-input type="email" v-model="email"></b-form-input>
        </b-input-group>
      </b-form-group>
    </b-modal>
    <b-modal id="reminder" ref="reminder" size="sm" title="パスワードを忘れた場合" ok-title="送信" close-title="キャンセル" no-auto-focus @ok="resetpassword" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
      <b-alert variant="info" :show="feedbacks['info'] !== undefined">
        <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
        <span>{{feedbacks['info']}}</span>
      </b-alert>
      <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
        {{feedbacks['error']}}
      </b-alert>
      <p>パスワードを再設定するには登録した電子メールアドレスを入力して送信ボタンを押してください。パスワードを再設定するためのURLを送信します。</p>
      <b-form-group label="電子メールアドレス" description="登録した電子メールアドレスを入力してください。" :feedback="feedbacks['email']" :state="states['email']">
        <b-input-group>
          <b-form-input type="email" v-model="email"></b-form-input>
        </b-input-group>
      </b-form-group>
    </b-modal>
    <b-modal id="resetPasswordModal" ref="resetPasswordModal" size="sm" title="パスワードのリセット" ok-title="送信" close-title="キャンセル" no-auto-focus @ok="savePassword" @shown="clearFeedbacks" :show="feedbacks['info'] !== undefined">
      <b-alert variant="info" :show="feedbacks['info'] !== undefined">
        <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
        <span>{{feedbacks['info']}}</span>
      </b-alert>
      <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
        {{feedbacks['error']}}
      </b-alert>
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
    <b-modal ref="confirmation" size="sm" title="本人確認用URLの送付" ok-only>
      <p>{{email}}に本人確認用のURLを送付しました。メールをご確認ください。</p>
    </b-modal>
    <b-modal ref="notifyPasswordReminder" size="sm" title="パスワード再設定用URLの送付" ok-only>
      <p>{{email}}にパスワード再設定用のURLを送付しました。メールをご確認ください。</p>
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
    return {
      email: '',
      password: '',
      feedbacks: {},
    }
  },
  beforeCreate: function() {
    document.body.className = 'root';
  },
  mounted() {
    // ログイン済みであればroomsに移動する。
    var vm = this;
    axios
      .get('/api/v2/users/signin')
      .then(function(response) {
        vm.$router.push({
          name: 'rooms'
        });
      })
      .catch(function(error) {
        // TODO
      })
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
        .get('/api/v2/users/confirmations', {
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
        .get('/api/v2/users/passwords', {
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
        email: this.getState('email'),
        password: this.getState('password')
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
      // HTTP Response has JSON with an error
      if (error.response.data.error !== undefined) {
        Vue.set(this.feedbacks, 'error', error.response.data.error);
        return;
      }
      // HTTP Response has JSON with errors
      if (error.response.data.errors !== undefined) {
        // Cleanup feedbacks
        Object.keys(this.feedbacks).forEach((key) => {
          Vue.delete(this.feedbacks, key)
        })
        // Set errors to fedbacks
        Object.keys(error.response.data.errors).forEach((key) => {
          var messages = error.response.data.errors[key]
          messages.forEach((message) => {
            // TODO Refactor
            if (key === 'reset_password_token') {
              Vue.set(this.feedbacks, key, 'このURLは既に使用されたか期限切れです。パスワードリセットするにはパスワードを再設定するためのURLの送信手続きを再度実施してください。')
            } else {
              Vue.set(this.feedbacks, key, `${this.$t(key)}${message}`)
            }
          })
        })
        return;
      }
      Vue.set(this.feedbacks, 'error', `Error: ${error.message}`)
    },
    clearFeedbacks() {
      Object.keys(this.feedbacks).forEach((key) => {
        Vue.delete(this.feedbacks, key)
      })
    },
    getState(key) {
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
          'content-type': 'multipart/form-data'
        },
        onUploadProgress: this.onUpload()
      };
      var vm = this;
      axios
        .post('/api/v2/users/signup', form, config)
        .then(function(response) {
          vm.$refs.signup.hide();
          vm.$refs.confirmation.show();
        })
        .catch(vm.onError)
    },
    signin(e) {
      e.cancel();
      var form = new FormData();
      form.append('user[email]', this.email);
      form.append('user[password]', this.password);
      var config = {
        headers: {
          'content-type': 'multipart/form-data',
        },
        onUploadProgress: this.onUpload()
      };
      var vm = this;
      axios
        .post('/api/v2/users/signin', form, config)
        .then(function(response) {
          vm.$router.push({
            name: 'rooms'
          });
        })
        .catch(vm.onError)
    },
    reconfirmation(e) {
      e.cancel();
      var form = new FormData();
      form.append('user[email]', this.email);
      var config = {
        headers: {
          'content-type': 'multipart/form-data',
        },
        onUploadProgress: this.onUpload()
      };
      var vm = this;
      axios
        .post('/api/v2/users/confirmations', form, config)
        .then(function(response) {
          vm.$refs.reconfirmation.hide();
          vm.$refs.confirmation.show();
        })
        .catch(vm.onError)
    },
    resetpassword(e) {
      e.cancel();
      var form = new FormData();
      form.append('user[email]', this.email);
      var config = {
        headers: {
          'content-type': 'multipart/form-data',
        },
        onUploadProgress: this.onUpload()
      };
      var vm = this;
      axios
        .post('/api/v2/users/passwords', form, config)
        .then(function(response) {
          vm.$refs.reminder.hide();
          vm.$refs.notifyPasswordReminder.show();
        })
        .catch(vm.onError)
    },
    savePassword(e) {
      e.cancel();
      var form = new FormData();
      form.append('user[password]', this.password);
      form.append('user[reset_password_token]', this.$route.query.reset_password_token);
      var config = {
        headers: {
          'content-type': 'multipart/form-data',
        },
        onUploadProgress: this.onUpload()
      };
      var vm = this;
      axios
        .put('/api/v2/users/passwords', form, config)
        .then(function(response) {
          vm.$refs.resetPasswordModal.hide()
          vm.$refs.finishSavePassword.show();
        })
        .catch(vm.onError)
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
