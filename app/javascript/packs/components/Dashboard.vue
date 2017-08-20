<template>
<div class="container">
  <h1>ダッシュボード</h1>
  <b-btn variant="primary" @click="signout">
    <span>ログアウト</span>
  </b-btn>
</div>
</template>
<script>
import axios from 'axios'
const api = axios.create()
export default {
  beforeCreate: function() {
    document.body.className = 'dashboard';
  },
  methods: {
    signout() {
      var vm = this;
      api
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
body.dashboard {
    background-color: $tc-color-light;
}
</style>
