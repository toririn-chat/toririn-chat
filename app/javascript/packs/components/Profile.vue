<template>
<div>
  <nav-bar/>
  <div class="container">
    <b-breadcrumb class="mt-3" :items="breadcrumb" />
    <b-form-group label="氏名" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
      <input type="text" readonly class="form-control-plaintext" :value="user.person_name">
    </b-form-group>
    <b-form-group label="組織名" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
      <input type="text" readonly class="form-control-plaintext" :value="user.organization_name">
    </b-form-group>
    <b-form-group label="電子メールアドレス" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
      <input type="text" readonly class="form-control-plaintext" :value="user.email">
    </b-form-group>
  </div>
</div>
</template>
<script>
import NavBar from './NavBar.vue'
import axios from 'axios'
export default {
  components: {
    NavBar
  },
  data() {
    return {
      breadcrumb: [{
        text: 'アカウント',
        active: true
      }, {
        text: '設定',
        active: true
      }],
      user: {
        person_name: '',
        organization_name: '',
        email: ''
      },
      feedbacks: []
    }
  },
  mounted() {
    this.getProfile()
  },
  methods: {
    getProfile() {
      let vm = this;
      axios({
        url: '/api/user',
        method: 'get'
      }).then(function(response) {
        vm.user = response.data;
      }).catch(function(error) {
        // TODO error handling
        // vm.feedbacks = []
        // vm.feedbacks.push(error.response.statusText)
      })
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
</style>
