<template>
<b-navbar toggleable type="dark">
  <b-nav-toggle target="nav_collapse"></b-nav-toggle>
  <b-navbar-brand href="/">とりりん<i class="fa fa-star"></i>チャット</b-navbar-brand>
  <b-collapse is-nav id="nav_collapse">
    <b-nav is-nav-bar>
      <b-nav-item href="rooms">
        <i class="fa fa-comments"></i>
        <span>チャットルーム</span>
      </b-nav-item>
    </b-nav>
    <b-nav is-nav-bar class="ml-auto">
      <b-nav-item-dropdown text="<i class='fa fa-user'></i>&nbsp;<span>アカウント</span>" right>
        <b-dropdown-item href="#">
          <i class="fa fa-gear"></i>
          <span>設定</span>
        </b-dropdown-item>
        <b-dropdown-divider></b-dropdown-divider>
        <b-dropdown-item @click="signout">
          <i class="fa fa-sign-out"></i>
          <span>ログアウト</span>
        </b-dropdown-item>
      </b-nav-item-dropdown>
    </b-nav>
  </b-collapse>
</b-navbar>
</div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      errors: []
    }
  },
  methods: {
    signout() {
      var vm = this;
      axios
        .delete('/api/v2/signout')
        .then(function(response) {
          vm.$router.push({
            name: 'root'
          });
        })
        .catch(function(error) {
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
