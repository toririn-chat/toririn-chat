<template>
<div>
  <nav-bar></nav-bar>
  <div class="container">
    <b-media v-for="message in messages" :key="message.id">
      <b-img blank width="64" height="64" slot="aside" blank-color="#abc" />
      <p>{{message.user_id}} {{message.created_at}}</p>
      <p v-show="message.text">{{message.text}}</p>
      <b-img width="150" height="150" blank-width="150" blank-height="150" blank-color="#fbfbfb" :src="`/images/stamps/${message.stamp}`" v-show="message.stamp" />
    </b-media>
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
    this.getMessages()
  },
  data() {
    return {
      messages: [{
        text: 'こんにちは！こんにちは！こんにちは！こんにちは！こんにちは！こんにちは！',
        user: {
          name: 'とりりん',
          icon: '/images/icons/animal_hamster.png'
        }
      }, {
        text: 'さようなら！さようなら！さようなら！さようなら！さようなら！さようなら！',
        user: {
          name: 'キャット',
          icon: '/images/icons/animal_penguin.png'
        }
      }],
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
    },
    getMessages() {
      var vm = this;
      axios
        .get(`/api/v2/rooms/${vm.$route.params.id}/messages.json`)
        .then(function(response) {
          vm.messages = response.data;
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
