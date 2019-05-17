<template>
  <v-app id="app">
    <Navbar  v-bind:withSidebar='false' v-bind:client='true'/>
    <Flash />
    <router-view class='top-margin min-height-full'></router-view>
  </v-app>
</template>

<script>
import Navbar from '../shared_components/Navbar'
import Flash from '../shared_components/Flash'

export default {
  name: 'App',
  components: {
    Navbar,
    Flash
  },
}
</script>

<style>
  .top-margin {
    margin-top: 64px;
  }
  .min-height-full {
    min-height: 80vh;
  }
</style>
