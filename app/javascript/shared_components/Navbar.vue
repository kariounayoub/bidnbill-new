<template>
  <div>
    <v-toolbar fixed class="navbar__main">

      <v-toolbar-side-icon class="navbar__icon"></v-toolbar-side-icon>
      <v-toolbar-title class="pointer navbar__header" @click='navigateLanding()'>BillSelector</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <router-link  :to="'/client_dashboard'">
          <p class='pointer navbar__link'>Dashboard</p>
        </router-link>
      </v-toolbar-items>
      <v-menu offset-y attach left>
        <v-avatar size="40" color="rgba(0,0,0,0)" class='pointer' slot="activator" >
          <img src="../../assets/images/avatar.jpg" alt="alt">
        </v-avatar>
        <v-list>
          <p class='pointer navbar__menu-item' @click='signOut()'>Déconnexion</p>
        </v-list>
      </v-menu>

    </v-toolbar>
  </div>

</template>

<script>
  import axios from 'axios'
  const ROOT_URL = `${window.location.origin}`;
  const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;
  const config = {
     headers: {
          Accept: 'application/json',
        'Content-Type': 'application/json',
         'X-CSRF-Token': csrfToken
        },
      credentials: "same-origin"
  }

  export default {
    name: 'Navbar',

    methods: {
      navigateLanding() {
        window.location.assign(ROOT_URL)
      },
      signOut() {
        axios.delete(`${ROOT_URL}/users/sign_out`, config)
        .then(res => window.location.assign(ROOT_URL))
      }
    }
  }
</script>

<style scoped lang="scss">
  .pointer {
    cursor: pointer;
  }
  .navbar__main {
    background: linear-gradient(98.45deg, #59E02A -22.29%, #FFFFFF 248.81%);
  }
  .navbar__icon {
    color: white !important;
  }
  .navbar__header {
    color: white;
    font-weight: 700;
  }
  .navbar__menu-item {
    padding: 20px;
    &:hover {
      background: #eee;
    };
  }
  a:hover {text-decoration: none;}
  .navbar__link {
    color: white;
    padding: 20px;
    font-weight: 600;
  }
</style>
