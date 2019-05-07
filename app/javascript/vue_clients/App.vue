<template>
  <v-app id="app">
    <Navbar />
    <DashboardInitial />
  </v-app>
</template>

<script>

import DashboardInitial from './views/DashboardInitial'
import Navbar from '../shared_components/Navbar'

export default {
  name: 'App',
  components: {
    DashboardInitial,
    Navbar
  }
}
</script>


<style>
  .v-btn {
    background: linear-gradient(251.31deg, #59E02A -32.76%, #FFFFFF 217.09%);
    color: white !important;
    text-transform: none !important;
    border-radius: 15px 2px 15px 2px !important;
    font-weight: 600 !important;
  }
</style>
