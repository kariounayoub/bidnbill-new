<template>
  <v-app id="app">
    <Navbar  v-bind:withSidebar='false'/>
    <Flash />
    <router-view class='top-margin min-height-full'></router-view>
    <Footer />
  </v-app>
</template>

<script>
import Navbar from '../shared_components/Navbar'
import Footer from '../shared_components/Footer'
import Flash from '../shared_components/Flash'

export default {
  name: 'App',
  components: {
    Navbar,
    Footer,
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
