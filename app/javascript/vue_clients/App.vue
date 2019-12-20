<template>
  <v-app id="app">
    <loading
      :active.sync="isLoading"
      :can-cancel="false"
      :is-full-page="true"
    ></loading>
    <Navbar
      v-bind:withSidebar="false"
      v-bind:client="true"
      v-bind:isValid="client.is_valid"
      v-bind:notifications="notifications"
      v-on:submitNotification="handleNotification"
      v-bind:avatarImg="client.picture"
    />
    <Flash />
    <router-view class="top-margin min-height-full"></router-view>
  </v-app>
</template>

<script>
import Navbar from "../shared_components/Navbar";
import Flash from "../shared_components/Flash";
// Import component
import Loading from "vue-loading-overlay";
// Import stylesheet
import "vue-loading-overlay/dist/vue-loading.css";

export default {
  name: "App",
  components: {
    Navbar,
    Flash,
    Loading
  },
  data: () => ({
    notifications: []
  }),
  computed: {
    isLoading() {
      return this.$store.getters.IsLoading;
    },
    client() {
      return this.$store.getters.Client.attributes;
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
