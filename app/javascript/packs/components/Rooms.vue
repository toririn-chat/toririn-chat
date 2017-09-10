<template>
<div>
  <nav-bar></nav-bar>
  <div class="container">
    <b-breadcrumb class="mt-3" :items="[{text:'チャットルーム',href:'/rooms',active:true}]" />
    <table class="table table-hover">
      <thead>
        <tr>
          <th>ルーム名</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="room in rooms">
          <td>{{room.name}}</td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
</template>
<script>
import NavBar from './NavBar.vue'
import axios from 'axios'
export default {
  beforeCreate: function() {
    document.body.className = 'dashboard';
  },
  components: {
    NavBar
  },
  data() {
    return {
      rooms: [],
      errors: []
    }
  },
  mounted: function() {
    this.getRooms()
  },
  methods: {
    getRooms() {
      var vm = this;
      axios
        .get('/api/v2/rooms.json')
        .then(function(response) {
          vm.rooms = response.data;
        })
        .catch(function(error) {
          vm.errors = []
          vm.errors.push(error.response.statusText)
        })
    }
  }
}
</script>
<style lang="scss">
@import "../styles/valiables";
body.dashboard {
    background-color: lighten($tc-color-light, 30%);
}
nav.navbar {
    background-color: $tc-color-dark;
}
</style>
