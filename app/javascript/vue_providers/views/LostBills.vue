<template>
  <div>
    <h3 class="dashboard__title">Nos Enchères Perdus</h3>
    <v-container>
      <BidTable  v-bind:myBids='true' v-bind:lostBills="true"/>
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
      return this.$store.getters.LostBills
    }
  },
  mounted() {
    this.$store.dispatch('GET_LOST_BILLS')
    this.interval = setInterval(() => {
      this.$store.dispatch('GET_LOST_BILLS')
    }, 10000);
  },
  beforeDestroy() {
    clearInterval(this.interval)
  }

};
</script>
