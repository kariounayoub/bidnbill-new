<template>
  <div>
    <h3 class="dashboard__title">Nos Enchères</h3>
    <v-container>
      <BidTable  v-bind:myBids='true'/>
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
  data: () => ({
    interval: null,
  }),
  computed: {
    allBills() {
      return this.$store.getters.Bills
    }
  },
  mounted() {
    if (this.allBills[0].attributes.id === null) {
      this.$store.dispatch('GET_BILLS')
    }
    this.interval = setInterval(() => {
      this.$store.dispatch('GET_BILLS')
    }, 10000);
  },
  beforeDestroy() {
    clearInterval(this.interval)
  }

};
</script>
