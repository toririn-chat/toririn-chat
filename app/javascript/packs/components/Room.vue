<template>
<div>
  <nav-bar />
  <div class="container">
    <b-breadcrumb class="mt-3" :items="breadcrumb" />
    <h3 class="my-3">
      <i class="fa fa-comments-o"></i>
      <span>{{room.name}}</span>
    </h3>
    <b-card no-body>
      <b-tabs ref="tabs" card>
        <b-tab title="設定" active>
          <b-form-group label="URL" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
            <a :href="room.url" target="_blank">{{ room.url }}</a>
            <!-- <input type="text" readonly class="form-control-plaintext" :value="room.url"> -->
          </b-form-group>
          <b-form-group label="QR code" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
            <b-img :src="room.qrcode_url" fluid alt="QR code" />
          </b-form-group>
          <b-form-group label="暗証番号" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
            <b-form-input type="text" :value="room.code" />
          </b-form-group>
          <b-form-group label="状態" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
            <b-form-input type="text"/>
          </b-form-group>
          <b-form-group label="有効期限の開始" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
            <b-form-input type="text"/>
          </b-form-group>
          <b-form-group label="有効期限の終了" horizontal label-class="font-weight-bold" label-cols="4" breakpoint="sm">
            <b-form-input type="text"/>
          </b-form-group>
        </b-tab>
        <b-tab title="書き込み一覧">
          開発中
        </b-tab>
      </b-tabs>
    </b-card>
  </div>
  <b-modal id="new_auth_uri" ref="new_auth_uri" size="sm" title="新規作成" ok-title="送信" cancel-title="キャンセル" @ok="" @shown="" :show="feedbacks['info'] !== undefined">
    <b-alert variant="info" :show="feedbacks['info'] !== undefined">
      <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>
      <span>{{feedbacks['info']}}</span>
    </b-alert>
    <b-alert variant="danger" :show="feedbacks['error'] !== undefined">
      {{feedbacks['error']}}
    </b-alert>
    <b-form-group label="チャットルーム名" :feedback="feedbacks['name']" :state="states['name']">
      <b-input-group>
        <b-form-input type="text" v-model="room.name" />
      </b-input-group>
    </b-form-group>
  </b-modal>
</div>
</template>
<script>
import NavBar from './NavBar.vue'
import Vue from 'vue'
import axios from 'axios'
import moment from 'moment'
export default {
  components: {
    NavBar
  },
  beforeCreate() {
    document.body.className = 'room';
  },
  mounted() {
    this.getRoom()
    // this.getMessages()
  },
  data() {
    return {
      room: {
        id: '',
        name: '',
        begin_at: '',
        end_at: '',
        token: '',
        url: '',
        code: '',
        qrcode_url: '',
        updated_at: '',
        created_at: '',
        messages: [],
      },
      feedbacks: []
    }
  },
  computed: {
    breadcrumb() {
      return [{
        text: 'チャットルーム一覧',
        href: '/rooms'
      }, {
        text: this.room.name,
        active: true
      }]
    },
    states() {
      return {
        name: this.getState('name')
      }
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
    // getMessages() {
    //   let vm = this;
    //   axios({
    //     url: `/api/rooms/${vm.$route.params.id}/messages`,
    //     method: 'get'
    //   }).then(function(response) {
    //     vm.messages = [];
    //     response.data.forEach((message) => {
    //       vm.messages.push(message)
    //     })
    //     Vue.nextTick(function() {
    //       window.scrollTo(0, document.body.scrollHeight);
    //     })
    //   }).catch(function(error) {
    //     // TODO error handling
    //     console.log(response.error);
    //   })
    // },
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
    },
    getState(key) {
      if (this.feedbacks[key] === undefined) {
        return 'valid';
      } else {
        return 'invalid';
      }
    },
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
</style>
