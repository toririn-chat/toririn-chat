<template>
<div>
  <nav-bar />
  <div class="container pb-3">
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
          <b-card header="概要" class="mb-3">
            <b-form-group label="状態" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
              <span class="form-control-plaintext"><b-badge active :variant="roomStatusBadgeVariant(room.status)" v-show="roomStatusBadgeString(room.status)">{{ roomStatusBadgeString(room.status) }}</b-badge></span>
            </b-form-group>
            <p v-show="!roomStatusIsActive(room.status)">現在、このチャットルームはアクセスできません。アクセスできるようにするためにはアクセス用リンクと暗証番号を設定してください。</p>
            <p v-show="roomStatusIsActive(room.status)">現在、このチャットルームはアクセス可能です。</p>
          </b-card>
          <b-card header="基本設定" class="mb-3">
            <b-form-group label="チャットルーム名" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm" :feedback="feedbacks['room.name']" :state="states['room.name']">
              <b-form-input type="text" v-model="room.name" />
            </b-form-group>
            <b-form-group label="備考欄" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
              <b-form-input type="text" v-model="room.description" />
            </b-form-group>
            <b-form-group horizontal class="text-right mb-0">
              <b-button variant="primary" @click="saveRoomConfig">保存</b-button>
            </b-form-group>
          </b-card>
          <b-card header="アクセス用リンク" class="mb-3">
            <div v-if="room.token">
              <b-form-group label="URL" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
                <a :href="room.url" class="form-control-plaintext" target="_blank">{{ room.url }}</a>
              </b-form-group>
              <b-form-group label="QRコード" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
                <b-img :src="room.qrcode_image_url" fluid alt="QRコード" class="m-10" width="129" height="129" blank-color="#eee" />
              </b-form-group>
              <b-form-group horizontal class="text-right mb-0">
                <b-button variant="danger" v-b-modal.delete_room_token>削除</b-button>
              </b-form-group>
            </div>
            <div v-else="room.token">
              <p>現在、このチャットルームはアクセス用リンクが無効です。チャットの利用者にチャットルームを公開するにはアクセス用リンクを生成してください。</p>
              <b-form-group horizontal class="text-right mb-0">
                <b-button variant="primary" @click="createRoomToken">アクセス用リンクの生成</b-button>
              </b-form-group>
            </div>
          </b-card>
          <b-card header="アクセス制限">
            <div v-if="room.code">
              <b-form-group label="暗証番号" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm" :feedback="feedbacks['room.code']" :state="states['room.code']">
                <b-form-input type="text" readonly v-model="room.code" />
              </b-form-group>
              <b-form-group horizontal class="text-right mb-0">
                <b-button variant="danger" v-b-modal.delete_room_code>削除</b-button>
              </b-form-group>
            </div>
            <div v-else="room.code">
              <p>現在、このチャットルームは暗証番号が無効です。チャットの利用者にチャットルームを公開するには暗証番号を生成してください。</p>
              <b-form-group horizontal class="text-right mb-0">
                <b-button variant="primary" @click="createRoomCode">暗証番号の生成</b-button>
              </b-form-group>
            </div>
          </b-card>
        </b-tab>
      </b-tabs>
    </b-card>
  </div>
  <b-modal id="delete_room_token" ref="delete_room_token" size="sm" title="アクセス用リンクを削除しますか？" ok-title="削除する" cancel-title="キャンセル" @ok="deleteRoomToken" ok-variant="danger">
    <p>アクセス用リンクを削除するとURLやQRコードを知っているチャットの利用者であっても、このチャットルームにアクセスできなくなります。</p>
    <p>また、削除した後に同じURLやQRコードを生成することはできません。</p>
  </b-modal>
  <b-modal id="delete_room_code" ref="delete_room_code" size="sm" title="暗証番号を削除しますか？" ok-title="削除する" cancel-title="キャンセル" @ok="deleteRoomCode" ok-variant="danger">
    <p>暗証番号を削除すると、このチャットルームにアクセスできなくなります。</p>
    <p>また、削除した後に同じ暗証番号を生成することはできません。</p>
  </b-modal>
</div>
</template>
<script>
import Vue from 'vue'
import axios from 'axios'
import moment from 'moment'
import NavBar from './NavBar.vue'
import feedbacks from '../plugins/feedbacks'
import rooms from '../plugins/rooms'
export default {
  mixins: [feedbacks, rooms],
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
        status: '',
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
    saveRoomConfig(event) {
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
      }).catch(vm.onFeedbacksErrors);
    },
    createRoomToken() {
      event.preventDefault();
      let vm = this;
      axios({
        resource: 'room',
        url: `/api/rooms/${vm.room.id}/create_token`,
        method: 'patch',
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
        onUploadProgress: vm.onFeedbacksProgress()
      }).then(function(response) {
        console.log(response.data);
        vm.room = response.data;
        vm.clearFeedbacks();
        vm.setSuccessFeedback();
      }).catch(vm.onFeedbacksErrors);
    },
    deleteRoomToken() {
      event.preventDefault();
      let vm = this;
      axios({
        resource: 'room',
        url: `/api/rooms/${vm.room.id}/delete_token`,
        method: 'patch',
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
        onUploadProgress: vm.onFeedbacksProgress()
      }).then(function(response) {
        vm.room = response.data;
        vm.clearFeedbacks();
        vm.setSuccessFeedback();
      }).catch(vm.onFeedbacksErrors);
    },
    createRoomCode() {
      event.preventDefault();
      let vm = this;
      axios({
        resource: 'room',
        url: `/api/rooms/${vm.room.id}/create_code`,
        method: 'patch',
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
        onUploadProgress: vm.onFeedbacksProgress()
      }).then(function(response) {
        console.log(response.data);
        vm.room = response.data;
        vm.clearFeedbacks();
        vm.setSuccessFeedback();
      }).catch(vm.onFeedbacksErrors);
    },
    deleteRoomCode() {
      event.preventDefault();
      let vm = this;
      axios({
        resource: 'room',
        url: `/api/rooms/${vm.room.id}/delete_code`,
        method: 'patch',
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        },
        onUploadProgress: vm.onFeedbacksProgress()
      }).then(function(response) {
        vm.room = response.data;
        vm.clearFeedbacks();
        vm.setSuccessFeedback();
      }).catch(vm.onFeedbacksErrors);
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
</style>
