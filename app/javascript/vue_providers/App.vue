<template>
  <v-app id="app">
    <Navbar
      class="front"
      v-bind:withSidebar="true"
      v-bind:isValid="isValid"
      v-bind:notifications="notifications"
      v-on:submitNotification="handleNotification"
    />
    <Sidebar v-if="!isMobile && isValid" />
    <SidebarMobile v-if="isMobile" />
    <Flash />
    <router-view
      class="top-margin min-height-full"
      v-bind:class="{ offset: !offset && isValid }"
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
  data: () => ({
    notifications: []
  }),
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
  },
  methods: {
    handleNotification(id) {
      this.notifications = this.notifications.filter(n => n.id !== id);
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
