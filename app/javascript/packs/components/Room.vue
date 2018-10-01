<template>
<div>
  <nav-bar />
  <div class="container">
    <b-breadcrumb class="mt-3" :items="breadcrumb" />
    <h3 class="my-3">
      <i class="fa fa-comments-o"></i>
      <span>{{ room.name }}</span>
    </h3>
    <b-card no-body>
      <b-tabs ref="tabs" card>
        <b-tab title="設定" active>
          <b-card header="基本設定" class="mb-3">
            <b-form-group label="チャットルーム名" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
              <b-form-input type="text" :value="room.name" />
            </b-form-group>
            <b-form-group label="備考欄" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
              <b-form-input type="text" :value="room.description" />
            </b-form-group>
            <b-form-group horizontal class="text-right mb-0">
              <b-button variant="primary">保存</b-button>
            </b-form-group>
          </b-card>
          <b-card header="リンク" class="mb-3">
            <b-form-group label="URL" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm" class="align-bottom">
              <a :href="room.url" class="form-control-plaintext" target="_blank">{{ room.url }}</a>
            </b-form-group>
            <b-form-group label="QR code" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
              <b-img :src="room.qrcode_image_url" fluid alt="QR code" class="m-10" width="129" height="129" blank-color="#eee" />
            </b-form-group>
            <b-form-group horizontal class="text-right mb-0">
              <b-button variant="primary">変更</b-button>
            </b-form-group>
          </b-card>
          <b-card header="アクセス制限">
            <b-form-group label="暗証番号" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
              <b-form-input type="text" :value="room.code" />
            </b-form-group>
            <b-form-group horizontal class="text-right mb-0">
              <b-button variant="primary">保存</b-button>
            </b-form-group>
          </b-card>
        </b-tab>
      </b-tabs>
    </b-card>
  </div>
</div>
</template>
<script>
import Vue from 'vue'
import axios from 'axios'
import moment from 'moment'
import NavBar from './NavBar.vue'
import feedbacks from '../plugins/feedbacks'
export default {
  components: {
    NavBar
  },
  beforeCreate() {
    document.body.className = 'room';
  },
  mounted() {
    this.getRoom();
  },
  data() {
    return {
      room: {
        id: '',
        name: '',
        description: '',
        url: '',
        qrcode_image_url: '',
        created_at: '',
        token: '',
        code: '',
        begin_at: '',
        end_at: ''
      }
    };
  },
  computed: {
    breadcrumb() {
      return [{
        text: 'チャットルーム一覧',
        href: '/rooms'
      }, {
        text: this.room.name,
        active: true
      }];
    }
  },
  filters: {
    moment(date) {
      moment.locale('ja');
      return moment(date).format('llll');
    }
  },
  methods: {
    getRoom() {
      let vm = this;
      axios({
        url: `/api/rooms/${vm.$route.params.id}`,
        method: 'get'
      }).then(function(response) {
        vm.room = response.data;
      })
      .catch(function(error) {
        // TODO error handling
        console.log(response.error);
      })
    },
    createAuthURI() {
      let vm = this;
      let form = new FormData();
      form.set('authorization[factor]', 'uri');
      axios({
        url: `/api/rooms/${vm.$route.params.id}/authorizations`,
        method: 'post',
        data: form
      }).then(function(response) {
        let authorization = response.data;
        vm.room.authorizations.unshift(authorization);
      }).catch(function(error) {
        console.log(error);
      })
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
</style>
