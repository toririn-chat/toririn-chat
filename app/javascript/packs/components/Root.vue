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
        <b-btn variant="primary" block :to="{name:'signup'}">
          <span>新規登録</span>
        </b-btn>
      </div>
    </div>
    <div class="row justify-content-center d-none d-sm-none d-md-flex mb-3">
      <div class="col-4">
        <b-btn variant="primary" block :to="{name:'signin'}">
          <span>ログイン</span>
        </b-btn>
      </div>
    </div>
  </div>
  <div class="container fixed-bottom d-md-none">
    <div class="row justify-content-center mb-3">
      <div class="col-12">
        <b-btn variant="primary" block :to="{name:'signup'}">
          <span>新規登録</span>
        </b-btn>
      </div>
    </div>
    <div class="row justify-content-center mb-3">
      <div class="col-12">
        <b-btn variant="primary" block :to="{name:'signin'}">
          <span>ログイン</span>
        </b-btn>
      </div>
    </div>
  </div>
</div>
</template>
<script>
import Vue from 'vue'
export default {
  data: () => {
    return {}
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
body,
html {
    height: 100%;
    width: 100%;
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
    a {
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
</style>
