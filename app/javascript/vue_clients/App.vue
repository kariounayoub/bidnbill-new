<template>
  <v-app id="app">
    <Navbar
      v-bind:withSidebar="false"
      v-bind:client="true"
      v-bind:isValid="isValid"
      v-bind:notifications="notifications"
      v-on:submitNotification="handleNotification"
    />
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
  data: () => ({
    notifications: []
  }),
  computed: {
    isValid() {
      return this.$store.getters.Client.attributes.is_valid;
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
    this.notifications = this.$store.getters.Client.attributes.notifications;
    this.$cable.subscribe(
      {
        channel: "NotificationsChannel",
        user_id: this.$store.getters.Client.attributes.id
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
