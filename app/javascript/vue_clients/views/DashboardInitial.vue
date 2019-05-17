<template>
  <div >
    <h3 class="dashboard__title">Bienvenue {{client.attributes.full_name}}</h3>
    <router-link  :to="'/bills/new'">
      <div class='flex-center add-bill-btn'><v-btn color="success large-text" large fab class=''>+</v-btn> Ajouter un abonnement</div>
    </router-link>
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
      if (this.bills[0].attributes.id === null) {
        this.$store.dispatch('GET_BILLS')
      }
    }
  }
</script>

<style scoped lang='scss'>
  .large-text {
    font-size: 40px;
  }
  .add-bill-btn {
    margin-top: 30px;
    margin-bottom:10px;
    font-weight: 700;
    font-size: 20px;
    color: var(--v-success-base)
  }

  a:hover {
    text-decoration: none;
  }

</style>
