<template>
<div class="container">
  <h1>とりりん<i class="fa fa-star"></i>チャット</h1>
  <p>
    <router-link :to="{name:'start'}" class="btn btn-primary">
      <span>はじめる</span>
    </router-link>
  </p>
</div>
</template>
<script>
</script>
<style lang="scss">
@import "../styles/valiables";
body {
    position: fixed;
    margin: 0;
    width: 100%;
    height: 100%;
    text-align: center;
    display: table;
    background-color: $tc-color-dark;
    .container {
        display: table-cell;
        text-align: center;
        vertical-align: middle;
        h1 {
            font-size: 32px;
            margin-bottom: 0.5em;
            color: $tc-color-light;
        }
        a {
            border-radius: 0.6rem;
            border: 0 none;
            color: $tc-color-dark;
            background-color: $tc-color-light;
            &:hover {
                color: lighten($tc-color-dark, 15%);
                background-color: lighten($tc-color-light, 30%);
            }
        }
    }
}
</style>
