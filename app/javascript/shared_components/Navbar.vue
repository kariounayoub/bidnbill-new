<template>
  <div>
    <v-toolbar fixed class="navbar__main">
      <v-toolbar-side-icon class="navbar__icon" @click.stop="toggleSidebar()" ></v-toolbar-side-icon>
      <v-toolbar-title class="pointer navbar__header" @click='navigateLanding()'>BillSelector</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <router-link  :to="{name: 'dashboard'}">
          <p class='pointer navbar__link'>Dashboard</p>
        </router-link>
      </v-toolbar-items>
      <v-menu offset-y attach left>
        <v-avatar size="40" color="rgba(0,0,0,0)" class='pointer' slot="activator" >
          <img src="../../assets/images/avatar.jpg" alt="alt">
        </v-avatar>
        <v-list>
          <router-link  :to="{name: 'edit_client'}" v-if='client'>
            <p class='pointer navbar__menu-item'>Modifier mon compte</p>
          </router-link>
          <router-link  :to="{name: 'edit_provider'}" v-if='!client'>
            <p class='pointer navbar__menu-item'>Modifier mon compte</p>
          </router-link>
          <p class='pointer navbar__menu-item' @click='signOut()'>Déconnexion</p>
        </v-list>
      </v-menu>

    </v-toolbar>
  </div>

</template>

<script>
  import axios from 'axios'
  const ROOT_URL = window.location.origin;
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
    props: {
      withSidebar: Boolean,
      client: Boolean,
    },
    methods: {
      toggleSidebar() {
        if(this.withSidebar) {
          this.$store.commit('TOOGLE_SIDEBAR_STATE')
        }
      },
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
  .navbar__main {
    background: linear-gradient(98.59deg, #6FE446 40.14%, #ACF094 99.89%);
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
    color: rgba(0,0,0,0.8);
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
