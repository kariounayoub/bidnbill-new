<template>
  <v-app id="app">
    <Navbar class="front" v-bind:withSidebar="true" v-bind:isValid="isValid" />
    <Sidebar v-if="!isMobile &&isValid" />
    <SidebarMobile v-if="isMobile" />
    <Flash />
    <router-view
      class="top-margin min-height-full"
      v-bind:class="{offset: !offset && isValid}"
      transition="slide-x-transition"
    ></router-view>
  </v-app>
</template>

<script>
import Navbar from "../shared_components/Navbar";
import Flash from "../shared_components/Flash";
import Sidebar from "./components/Sidebar";
import SidebarMobile from "./components/SidebarMobile";

export default {
  name: "App",
  components: {
    Navbar,
    Flash,
    Sidebar,
    SidebarMobile
  },
  computed: {
    isMobile() {
      return screen.width <= 600 ? true : false;
    },
    isValid() {
      return this.$store.getters.Provider.attributes.is_valid;
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
