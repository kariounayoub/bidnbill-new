<template>
  <v-app id="app">
    <loading
      :active.sync="isLoading"
      :can-cancel="false"
      :is-full-page="true"
    ></loading>
    <Navbar
      class="front"
      v-bind:withSidebar="true"
      v-bind:isValid="provider.is_valid"
      v-bind:notifications="notifications"
      v-on:submitNotification="handleNotification"
      v-bind:isAdmin="provider.account_admin"
      v-bind:avatarImg="provider.picture"
    />
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
// Import component
import Loading from "vue-loading-overlay";
// Import stylesheet
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
  data: () => ({
    notifications: []
  }),
  computed: {
    isLoading() {
      return this.$store.getters.IsLoading;
    },
    isMobile() {
      return screen.width <= 600 ? true : false;
    },
    provider() {
      return this.$store.getters.Provider.attributes;
    },
    offset() {
      return this.$store.getters.Offset;
    }
  },
  methods: {
    handleNotification(id) {
      this.notifications = this.notifications.filter(n => n.data.id !== id);
      this.$store.dispatch("SEEN_NOTIFICATIONS", id);
    }
  },
  channels: {
    notifications_channel: {
      connected() {
        console.log("WS Connected");
      },
      received({ notification }) {
        console.log("recieved");
        this.notifications.push(notification);
      }
    }
  },
  mounted() {
    this.notifications = this.$store.getters.Provider.attributes.notifications;
    this.$cable.subscribe(
      {
        channel: "NotificationsChannel",
        user_id: this.$store.getters.Provider.attributes.id
      },
      "notifications_channel"
    );
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
