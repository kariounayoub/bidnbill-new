<template>
  <div >
    <h3 class="dashboard__title">Bienvenue {{client.attributes.full_name}}</h3>
    <v-container>
      <v-layout row wrap>
        <v-flex xs12 sm6 v-for="bill in bills" v-bind:key='bill.attributes.id'>
          <BillCardDashboard v-bind:bill='bill' />
        </v-flex>
      </v-layout>
    </v-container>

  </div>
</template>

<script>

  import BillCardDashboard from '../components/BillCardDashboard'
  export default {
    name: 'DashboardInitial',
    components: {
      BillCardDashboard
    },
    computed: {
      client() {
        return this.$store.getters.Client
      },
      bills() {
        return this.$store.getters.Bills
      }
    },
    mounted() {
      this.$store.dispatch('GET_BILLS');
    }
  }
</script>
