<template>
  <div class='top-margin'>
    <h3 class="dashboard__title">Bienvenue {{client.attributes.full_name}}</h3>
    <v-container>
      <v-layout row wrap>
        <v-flex xs12 sm6 v-for="bill in bills">
          <BillCard v-bind:bill='bill' />
        </v-flex>
      </v-layout>
    </v-container>

  </div>
</template>

<script>

  import BillCard from '../components/BillCard'
  export default {
    name: 'DashboardInitial',
    components: {
      BillCard
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

<style scoped>
  .top-margin {
    margin-top: 64px;
  }
  .dashboard__title {
    font-weight: 700;
    color: rgba(0,0,0,0.8);
    margin: 15px auto;
    text-align: center;
  }
</style>
