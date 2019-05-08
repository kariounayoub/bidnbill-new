<template>
  <v-app id="app">
    <Navbar />
    <router-view class='top-margin min-height-full'></router-view>
    <Footer />
  </v-app>
</template>

<script>
import Navbar from '../shared_components/Navbar'
import Footer from '../shared_components/Footer'

export default {
  name: 'App',
  components: {
    Navbar,
    Footer
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
