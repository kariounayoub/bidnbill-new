<template>
  <div>
    <h3 class="dashboard__title">Enchères en cours</h3>
    <v-container fluid>
      <BidTable v-bind:myBids="false" />
    </v-container>
  </div>
</template>

<script>
import BidTable from "../components/BidTable";

export default {
  name: "DashboardInitial",
  components: {
    BidTable
  },
  data: () => ({
    interval: null
  }),
  computed: {
    allBills() {
      return this.$store.getters.Bills;
    }
  },
  mounted() {
    if (this.allBills[0].attributes.id === null) {
      this.$store.dispatch("GET_BILLS");
    }
    this.interval = setInterval(() => {
      this.$store.dispatch("GET_BILLS");
    }, 10000);
  },
  beforeDestroy() {
    clearInterval(this.interval);
  }
};
</script>
