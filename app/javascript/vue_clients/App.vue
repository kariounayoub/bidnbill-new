<template>
  <v-app id="app">
    <Navbar v-bind:withSidebar="false" v-bind:client="true" v-bind:isValid="isValid" />
    <Flash />
    <router-view class="top-margin min-height-full"></router-view>
  </v-app>
</template>

<script>
import Navbar from "../shared_components/Navbar";
import Flash from "../shared_components/Flash";

export default {
  name: "App",
  components: {
    Navbar,
    Flash
  },
  computed: {
    isValid() {
      return this.$store.getters.Client.attributes.is_valid;
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
