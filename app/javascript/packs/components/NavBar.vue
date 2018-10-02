<template>
<div>
  <b-navbar toggleable type="dark">
    <b-navbar-brand href="/">とりりん<i class="fa fa-star"></i>チャット</b-navbar-brand>
    <b-nav-toggle target="nav_collapse" />
    <b-collapse is-nav id="nav_collapse">
      <b-navbar-nav>
        <b-nav-item href="rooms">
          <i class="fa fa-comments"></i>
          <span>チャットルーム</span>
        </b-nav-item>
      </b-navbar-nav>
      <b-navbar-nav class="ml-auto">
        <b-nav-item-dropdown text="<i class='fa fa-user'></i>&nbsp;<span>アカウント</span>" right>
          <b-dropdown-item href="profile">
          <i class="fa fa-gear"></i>
          <span>設定</span>
        </b-dropdown-item>
        <b-dropdown-divider />
        <b-dropdown-item @click="signout">
          <i class="fa fa-sign-out"></i>
          <span>ログアウト</span>
        </b-dropdown-item>
        </b-nav-item-dropdown>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
</div>
</template>
<script>
import axios from 'axios'
export default {
  methods: {
    signout() {
      let vm = this;
      axios({
        url: '/api/users/signout',
        method: 'delete'
      }).then(function(response) {
        vm.$router.push({
          name: 'root'
        });
      }).catch(function(error) {
        vm.$router.push({
          name: 'root'
        });
      })
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
nav.navbar {
  background-color: $tc-color-dark;
}
</style>
