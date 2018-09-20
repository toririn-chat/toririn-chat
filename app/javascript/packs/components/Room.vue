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
        <b-tab title="概要" active>
          <h4>URL</h4>
          開発中
          <h4>QRコード</h4>
          開発中
        </b-tab>
        <b-tab title="書き込み一覧">
          開発中
        </b-tab>
        <b-tab title="アクセス制限">
          <h4>暗証番号</h4>
          <p>このチャットルームにアクセスするための暗証番号を管理します。セキュリティ対策のため、暗証番号は新規作成してから<strong>6時間</strong>だけ有効です。有効期限を過ぎると自動的に削除されます。このチャットルームへのログインを長期的に許可したい場合は、QRコードまたはURLによる認可方式を使用してください。
          </p>
          <b-button variant="primary" class="mb-3" v-b-modal.new_auth_code>
            新規作成
          </b-button>
          <table class="table table-hover">
            <thead class="thead-default">
              <tr>
                <th class="align-top">暗証番号</th>
                <th class="align-top">有効期間の開始</th>
                <th class="align-top">有効期間の終了</th>
                <th class="align-top">利用回数</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="auth in codeAuthorizations">
                <td class="align-top text-nowrap">{{auth.code}}</td>
                <td class="align-top">{{auth.begin_at | moment}}</td>
                <td class="align-top">{{auth.end_at | moment}}</td>
                <td class="align-top text-right">{{auth.count}}</td>
              </tr>
            </tbody>
          </table>
        </b-tab>
      </b-tabs>
    </b-card>
  </div>
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
    this.getMessages()
  },
  data() {
    return {
      room: {
        id: '',
        name: '',
        updated_at: '',
        created_at: '',
        authorizations: []
      },
      messages: [],
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
    codeAuthorizations() {
      return this.room.authorizations.filter((e, i, a) => {
        return e.factor === 'code'
      })
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
    getMessages() {
      let vm = this;
      axios({
        url: `/api/rooms/${vm.$route.params.id}/messages`,
        method: 'get'
      }).then(function(response) {
        vm.messages = [];
        response.data.forEach((message) => {
          vm.messages.push(message)
        })
        Vue.nextTick(function() {
          window.scrollTo(0, document.body.scrollHeight);
        })
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
</style>
