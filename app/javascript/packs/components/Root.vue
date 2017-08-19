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
    <b-modal id="signup" size="sm" title="新規登録" ok-title="新規登録" close-title="キャンセル">
      <b-form-group label="電子メールアドレス" description="入力した電子メールアドレスに新規登録用のURLを送信します。">
        <b-input-group>
          <b-form-input type="email"></b-form-input>
        </b-input-group>
      </b-form-group>
      <b-form-group label="パスワード" description="半角で8文字以上の長さにしてください。">
        <b-input-group>
          <b-form-input type="password"></b-form-input>
        </b-input-group>
      </b-form-group>
    </b-modal>
    <b-modal id="signin" size="sm" title="ログイン" ok-title="ログイン" close-title="キャンセル">
      <b-form-group label="電子メールアドレス" description="登録した電子メールアドレスを入力してください。">
        <b-input-group>
          <b-form-input type="email"></b-form-input>
        </b-input-group>
      </b-form-group>
      <b-form-group label="パスワード" description="登録したパスワードを入力してください。">
        <b-input-group>
          <b-form-input type="password"></b-form-input>
        </b-input-group>
      </b-form-group>
    </b-modal>
  </div>
</div>
</template>
<script>
export default {}
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
