<template>
  <div>
    <v-toolbar fixed class="navbar__main">
      <v-toolbar-side-icon
        class="navbar__icon"
        @click.stop="toggleSidebar()"
      ></v-toolbar-side-icon>
      <v-toolbar-title
        class="pointer navbar__header"
        @click="navigateLanding()"
      >
        <img :src="image" class="logo" />
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <router-link :to="{ name: 'dashboard' }" v-if="isValid">
          <p class="pointer navbar__link">Dashboard</p>
        </router-link>
        <router-link :to="{ name: 'edit_client' }" v-if="client && !isValid">
          <p class="pointer navbar__link">Valider mon compte</p>
        </router-link>
        <router-link :to="{ name: 'edit_provider' }" v-if="!client && !isValid">
          <p class="pointer navbar__link">Valider mon compte</p>
        </router-link>
      </v-toolbar-items>
      <v-menu
        offset-y
        attach
        left
        v-if="notifications && notifications.length > 0"
      >
        <div class="notifications" slot="activator">
          <v-icon class="notification-icon">notifications </v-icon>
          <div class="notifications-count">
            {{ notifications.length }}
          </div>
        </div>

        <v-list>
          <div
            class="notification-content"
            v-for="notification in notifications"
          >
            <span class="notification-content__content">
              {{ notification.content }}
            </span>

            <span
              class="notification-content__icon"
              v-on:click="$emit('submitNotification', notification.id)"
              ><v-icon>check</v-icon></span
            >
          </div>
        </v-list>
      </v-menu>
      <v-menu offset-y attach left>
        <v-avatar
          size="40"
          color="rgba(0,0,0,0)"
          class="pointer"
          slot="activator"
        >
          <img src="../../assets/images/avatar.jpg" alt="alt" />
        </v-avatar>
        <v-list>
          <router-link :to="{ name: 'edit_client' }" v-if="client">
            <p class="pointer navbar__menu-item">Modifier mon compte</p>
          </router-link>
          <router-link :to="{ name: 'edit_provider' }" v-if="!client">
            <p class="pointer navbar__menu-item">Modifier mon compte</p>
          </router-link>
          <p class="pointer navbar__menu-item" @click="signOut()">
            Déconnexion
          </p>
        </v-list>
      </v-menu>
    </v-toolbar>
  </div>
</template>

<script>
import axios from "axios";
const ROOT_URL = window.location.origin;
const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes
  .content.value;
const config = {
  headers: {
    Accept: "application/json",
    "Content-Type": "application/json",
    "X-CSRF-Token": csrfToken
  },
  credentials: "same-origin"
};

import image from "../../assets/images/logo-light.png";

export default {
  name: "Navbar",
  props: {
    withSidebar: Boolean,
    client: Boolean,
    isValid: Boolean,
    notifications: Array
  },
  data: () => ({
    image: image
  }),
  methods: {
    toggleSidebar() {
      if (this.withSidebar) {
        this.$store.commit("TOOGLE_SIDEBAR_STATE");
      }
    },
    navigateLanding() {
      window.location.assign(ROOT_URL);
    },
    signOut() {
      axios
        .delete(`${ROOT_URL}/users/sign_out`, config)
        .then(res => window.location.assign(ROOT_URL));
    }
  }
};
</script>
