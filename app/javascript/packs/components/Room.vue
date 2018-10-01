<template>
<div>
  <nav-bar />
  <div class="container">
    <b-breadcrumb class="mt-3" :items="breadcrumb" />
    <h3 class="my-3">
      <i class="fa fa-comments-o"></i>
      <span>{{ room.name }}</span>
    </h3>
    <b-alert variant="success" :show="feedbacks['success'] !== undefined" dismissible fade>
      <span>{{ feedbacks['success'] }}</span>
    </b-alert>
    <b-card no-body>
      <b-tabs ref="tabs" card>
        <b-tab title="設定" active>
          <b-card header="基本設定" class="mb-3">
            <b-form-group label="チャットルーム名" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm" :feedback="feedbacks['room.name']" :state="states['room.name']">
              <b-form-input type="text" v-model="room.name" />
            </b-form-group>
            <b-form-group label="備考欄" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
              <b-form-input type="text" v-model="room.description" />
            </b-form-group>
            <b-form-group horizontal class="text-right mb-0">
              <b-button variant="primary" @click="saveRoomBasicConfig">保存</b-button>
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
            <b-form-group label="暗証番号" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm"  :feedback="feedbacks['room.code']" :state="states['room.code']">
              <b-form-input type="text" v-model="room.code" />
              <b-form-text>6〜20文字の数値を指定してください。</b-form-text>
            </b-form-group>
            <b-form-group horizontal class="text-right mb-0">
              <b-button variant="primary" @click="saveRoomAccessConfig">保存</b-button>
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
  mixins: [feedbacks],
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
      }).catch(vm.onFeedbacksErrors)
    },
    saveRoomBasicConfig(event) {
      event.preventDefault();
      let vm = this;
      let form = new FormData();
      form.set('room[name]', vm.room.name);
      form.set('room[description]', vm.room.description);
      axios({
        resource: 'room',
        url: `/api/rooms/${vm.room.id}`,
        method: 'patch',
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
        data: form,
        onUploadProgress: vm.onFeedbacksProgress()
      }).then(function(response) {
        vm.clearFeedbacks();
        vm.setSuccessFeedback();
      }).catch(vm.onFeedbacksErrors)
    },
    saveRoomAccessConfig(event) {
      event.preventDefault();
      let vm = this;
      let form = new FormData();
      form.set('room[code]', vm.room.code);
      axios({
        resource: 'room',
        url: `/api/rooms/${vm.room.id}`,
        method: 'patch',
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
        data: form,
        onUploadProgress: vm.onFeedbacksProgress()
      }).then(function(response) {
        vm.clearFeedbacks();
        vm.setSuccessFeedback();
      }).catch(vm.onFeedbacksErrors)
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
</style>
