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
