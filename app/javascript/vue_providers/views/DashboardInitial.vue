<template>
  <div>
    <h3 class="dashboard__title">Enchères en cours</h3>
    <v-container>
      <BidTable v-bind:bills='bills' v-bind:canBid='true'/>
    </v-container>
  </div>
</template>

<script>
  import BidTable from '../components/BidTable'

export default {
  name: 'DashboardInitial',
  components: {
    BidTable,
  },
  computed: {
    bills() {
      return this.$store.getters.OtherBills
    },
    allBills() {
      return this.$store.getters.Bills
    }
  },
  mounted() {
    if (this.allBills[0].attributes.id === null) {
      this.$store.dispatch('GET_BILLS')
    }
  },

};
</script>
