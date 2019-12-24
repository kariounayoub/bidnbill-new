<template>
  <v-app id="app">
    <loading :active.sync="isLoading" :can-cancel="false" :is-full-page="true"></loading>
    <Navbar v-bind:withSidebar="false" v-bind:client="true" />
    <Flash />
    <router-view class="top-margin min-height-full"></router-view>
  </v-app>
</template>

<script>
import Navbar from "../shared_components/Navbar";
import Flash from "../shared_components/Flash";
import Loading from "vue-loading-overlay";
import "vue-loading-overlay/dist/vue-loading.css";

export default {
  name: "App",
  components: {
    Navbar,
    Flash,
    Loading
  },
  computed: {
    isLoading() {
      return this.$store.getters.IsLoading;
    }
  }
};
</script>

<style>
.top-margin {
  margin-top: 64px;
}
.min-height-full {
  min-height: 80vh;
}
</style>
