<template>
<div>
  <nav-bar></nav-bar>
  <div class="container">
    <b-breadcrumb class="mt-3" :items="breadcrumb" />

    <!-- <b-form-group horizontal label="管理者">
      <b-form-input plaintext></b-form-input>
    </b-form-group> -->

    <h3>管理機能</h3>
    <h4>認可</h4>
    <h5>URL</h5>
    <p>作成中</p>
    <h5>QRコード発行</h5>
    <p>作成中</p>
    <table class="table table-hover">
    </table>
    <h5>トークン発行</h5>
    <p>作成中</p>
    <table class="table table-hover">
    </table>
    <h5>IPアドレス制限</h5>
    <p>作成中</p>
    <table class="table table-hover">
    </table>
    <h4>メッセージ</h4>
    <h5>メッセージ一覧</h5>
    <p>作成中</p>
    <h5>CSVエクスポート</h5>
    <p>作成中</p>
  </div>
</div>
</template>
<script>
import NavBar from './NavBar.vue'
import Vue from 'vue'
import axios from 'axios'
export default {
  components: {
    NavBar
  },
  beforeCreate() {
    document.body.className = 'room';
  },
  mounted() {
    this.getRoom()
  },
  data() {
    return {
      room: {
        id: '',
        name: '',
        updated_at: '',
        created_at: '',
      },
      feedbacks: []
    }
  },
  computed: {
    breadcrumb() {
      return [{
        text: 'チャットルーム',
        href: '/rooms',
        active: false
      }, {
        text: this.room.name
      }]
    },

  },
  methods: {
    getRoom() {
      var vm = this;
      axios
        .get(`/api/v2/rooms/${vm.$route.params.id}`)
        .then(function(response) {
          vm.room = response.data;
        })
        .catch(function(error) {
          // TODO error handling
          console.log(response.error);
        })
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
body {
    background-color: lighten($tc-color-light, 30%);
}
</style>
