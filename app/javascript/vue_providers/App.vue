<template>
  <v-app id="app">
    <loading :active.sync="isLoading" :can-cancel="false" :is-full-page="true"></loading>
    <Navbar class="front" v-bind:withSidebar="true" />
    <Sidebar v-if="!isMobile" />
    <SidebarMobile v-if="isMobile" />
    <Flash />
    <router-view
      class="top-margin min-height-full"
      v-bind:class="{ offset: !offset }"
      transition="slide-x-transition"
    ></router-view>
  </v-app>
</template>

<script>
import Navbar from "../shared_components/Navbar";
import Flash from "../shared_components/Flash";
import Sidebar from "./components/Sidebar";
import SidebarMobile from "./components/SidebarMobile";
import Loading from "vue-loading-overlay";
import "vue-loading-overlay/dist/vue-loading.css";

export default {
  name: "App",
  components: {
    Navbar,
    Flash,
    Sidebar,
    SidebarMobile,
    Loading
  },
  computed: {
    isLoading() {
      return this.$store.getters.IsLoading;
    },
    isMobile() {
      return screen.width <= 600 ? true : false;
    },
    offset() {
      return this.$store.getters.Offset;
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
