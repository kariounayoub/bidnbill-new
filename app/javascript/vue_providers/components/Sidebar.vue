<template>
  <div id="sidebar"  >
    <v-slide-x-transition >
    <v-navigation-drawer fixed width="200" v-show="!offset"  permanent >
      <v-list dense class="pt-0">
        <router-link  v-for="item in items" :key="item.title" :to="item.path" >
          <v-list-tile >
            <v-list-tile-action>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-tile-action>

            <v-list-tile-content >
              <v-list-tile-title >{{ item.title }}</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </router-link>
      </v-list>
    </v-navigation-drawer>
  </v-slide-x-transition>
  </div>
</template>

<script>
  export default {
    name: 'Sidebar',
    data () {
      return {
        items: [
          { title: 'Enchères en cours', icon: 'inbox', path: '/provider_dashboard' },
          { title: 'Nos enchères', icon: 'star', path: '/provider_encheres' },
          { title: 'Nos Clients', icon: 'person', path: '/provider_clients' }
        ],
      }
    },
    computed: {
      offset() {
        return this.$store.getters.Offset
      }
    },
  }
</script>

