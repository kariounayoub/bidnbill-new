<template>
  <v-app id="app">
    <Navbar />
    <router-view class='top-margin'></router-view>
  </v-app>
</template>

<script>
import Navbar from '../shared_components/Navbar'

export default {
  name: 'App',
  components: {
    Navbar
  },
}
</script>

<style>
  .top-margin {
    margin-top: 64px;
  }
</style>
