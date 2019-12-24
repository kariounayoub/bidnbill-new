<template>
  <div>
    <v-toolbar fixed class="navbar__main">
      <v-toolbar-side-icon class="navbar__icon" @click.stop="toggleSidebar()" v-if="withSidebar"></v-toolbar-side-icon>
      <v-toolbar-title class="pointer navbar__header" @click="navigateLanding()">
        <img :src="image" class="logo" />
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <router-link :to="{ name: 'dashboard' }" v-if="user.is_valid || !client">
          <p class="pointer navbar__link">Dashboard</p>
        </router-link>
        <router-link :to="{ name: 'edit_client' }" v-if="client && !user.is_valid">
          <p class="pointer navbar__link">Valider mon compte</p>
        </router-link>
      </v-toolbar-items>
      <v-menu offset-y attach left v-if="notifications && notifications.length > 0">
        <div class="notifications" slot="activator">
          <v-icon class="notification-icon">notifications</v-icon>
          <div class="notifications-count">{{ notifications.length }}</div>
        </div>

        <v-list>
          <div class="notification-content" v-for="notification in notifications">
            <router-link
              :to="
                notification.data.attributes.category === 'new bid'
                  ? '/bills/' + notification.data.attributes.bill
                  : '/provider_clients'
              "
            >
              <span
                class="notification-content__content"
                v-on:click="handleNotification(notification.data.id)"
              >{{ notification.data.attributes.content }}</span>
            </router-link>

            <span
              class="notification-content__icon"
              v-on:click="handleNotification(notification.data.id)"
            >
              <v-icon>check</v-icon>
            </span>
          </div>
        </v-list>
      </v-menu>
      <v-menu offset-y attach left>
        <v-avatar size="40" color="rgba(0,0,0,0)" class="pointer" slot="activator">
          <img :src="user.picture ? user.picture : '../../assets/images/avatar.jpg'" alt="alt" />
        </v-avatar>
        <v-list>
          <router-link :to="{ name: 'edit_client' }" v-if="client">
            <p class="pointer navbar__menu-item">Modifier mon compte</p>
          </router-link>
          <router-link :to="{ name: 'edit_provider' }" v-if="!client">
            <p class="pointer navbar__menu-item">Modifier mon compte</p>
          </router-link>
          <router-link :to="{ name: 'edit_account' }" v-if="!client && user.is_admin">
            <p class="pointer navbar__menu-item">Gérer mon compte entreprise</p>
          </router-link>
          <p class="pointer navbar__menu-item" @click="signOut()">Déconnexion</p>
        </v-list>
      </v-menu>
    </v-toolbar>
  </div>
</template>

<script>
import image from "../../assets/images/logo-light.png";

export default {
  name: "Navbar",
  props: {
    withSidebar: Boolean,
    client: Boolean
  },
  data: () => ({
    image: image,
    notifications: []
  }),
  computed: {
    user() {
      if (this.client) {
        return this.$store.getters.Client.attributes;
      } else {
        return this.$store.getters.Provider.attributes;
      }
    }
  },
  methods: {
    toggleSidebar() {
      if (this.withSidebar) {
        this.$store.commit("TOOGLE_SIDEBAR_STATE");
      }
    },
    navigateLanding() {
      window.location.assign(window.location.origin);
    },
    signOut() {
      this.$store.dispatch("SIGN_OUT");
    },
    handleNotification(id) {
      this.notifications = this.notifications.filter(n => n.data.id !== id);
      this.$store.dispatch("SEEN_NOTIFICATIONS", id);
    }
  },
  channels: {
    notifications_channel: {
      received({ notification }) {
        this.notifications.push(notification);
      }
    }
  },
  mounted() {
    this.notifications = this.client
      ? this.$store.getters.Client.attributes.notifications
      : this.$store.getters.Provider.attributes.notifications;

    this.$cable.subscribe(
      {
        channel: "NotificationsChannel",
        user_id: this.client
          ? this.$store.getters.Client.attributes.id
          : this.$store.getters.Provider.attributes.id
      },
      "notifications_channel"
    );
  }
};
</script>
