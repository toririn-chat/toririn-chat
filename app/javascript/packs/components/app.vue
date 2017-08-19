<template>
<router-view>
</router-view>
</template>
<script>
// import 'bootstrap-loader'

import Vue from 'vue'
import 'font-awesome-sass-loader'
import BootstrapVue from 'bootstrap-vue'
Vue.use(BootstrapVue)
export default {}
</script>
<style lang="scss">
@import "../styles/valiables";
@import 'bootstrap-vue/dist/bootstrap-vue.css';
@import 'bootstrap/dist/css/bootstrap.css';
</style>
