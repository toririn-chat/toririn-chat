<template>
<div>
  <b-navbar toggleable type="dark" fixed="top" sticky>
    <b-navbar-brand>{{room.title}}</b-navbar-brand>
  </b-navbar>
  <div class="container">
    <b-media v-for="message in messages" :key="message.id">
      <b-img width="64" height="64" slot="aside" blank-color="#abc" :src="message.person_avatar_image_url" />
      <p>{{message.person_name}} {{message.created_at}}</p>
      <p v-show="message.text">{{message.text}}</p>
      <b-img width="150" height="150" blank-width="150" blank-height="150" blank-color="#fbfbfb" :src="message.sticker_image_url" v-show="message.sticker_image_url" />
    </b-media>
  </div>
</div>
</template>
<script>
import Vue from 'vue'
import axios from 'axios'
export default {
  beforeCreate() {
    document.body.className = 'chat';
  },
  mounted() {
    this.getRoom()
    this.getMessages()
  },
  data() {
    return {
      messages: [],
      room: {
        id: '',
        name: '',
        updated_at: '',
        created_at: '',
      },
      person: {
        id: ''
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
