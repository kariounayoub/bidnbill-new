<template>
  <v-app id="app">
    <Navbar class='front' v-bind:withSidebar='true'/>
    <Sidebar />
    <Flash />
    <router-view class='top-margin min-height-full'  v-bind:class="{offset: !offset}" transition='slide-x-transition'></router-view>
  </v-app>
</template>

<script>
import Navbar from '../shared_components/Navbar'
import Flash from '../shared_components/Flash'
import Sidebar from './components/Sidebar'

export default {
  name: 'App',
  components: {
    Navbar,
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
</style>
