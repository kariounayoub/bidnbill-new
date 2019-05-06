<template>
  <v-app id="app">
    <DashboardInitial />
  </v-app>
</template>

<script>

import DashboardInitial from './views/DashboardInitial'

export default {
  name: 'App',
  components: {
    DashboardInitial,
  }
}
</script>
