<template>
  <v-app id="app">
    <Navbar class='front' v-bind:withSidebar='true'/>
    <Sidebar />
    <Flash />
    <router-view class='top-margin min-height-full' v-bind:class="{offset: !offset}" transition='slide-x-transition'></router-view>
    <Footer class='front'/>
  </v-app>
</template>

<script>
import Navbar from '../shared_components/Navbar'
import Footer from '../shared_components/Footer'
import Flash from '../shared_components/Flash'
import Sidebar from './components/Sidebar'

export default {
  name: 'App',
  components: {
    Navbar,
    Footer,
    Flash,
    Sidebar
  },
  computed: {
    offset () {
      return this.$store.getters.Offset
    }
  }
}
</script>

<style>
  .top-margin {
    margin-top: 64px;
  }
  .min-height-full {
    min-height: 80vh;
  }
  .front {
    z-index: 1200;
  }
</style>
