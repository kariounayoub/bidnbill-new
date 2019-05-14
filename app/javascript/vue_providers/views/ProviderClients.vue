<template>
  <div>
    <h3 class="dashboard__title">Mes Clients</h3>
    <v-container>
      <v-layout row wrap class='inside-card'>
        <v-flex xs12 sm8 >
          <ClientTable v-bind:clients='myClients' />
        </v-flex>
        <v-flex xs12 sm4>
          <ClientCard v-if='activeClient' v-bind:client='activeClient'/>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
  import ClientTable from '../components/ClientTable'
  import ClientCard from '../components/ClientCard'

export default {
  name: 'ProviderClients',
  components: {
    ClientTable,
    ClientCard
  },
  computed: {
    myClients() {
      return this.$store.getters.MyClients
    },
    activeClient() {
      return this.$store.getters.ActiveClient
    }
  },
  mounted() {
    if (this.myClients[0].bill.data.id === null) {
      this.$store.dispatch('GET_MY_CLIENTS')
    }
  },

};
</script>
