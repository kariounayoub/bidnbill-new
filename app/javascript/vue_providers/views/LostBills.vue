<template>
  <div>
    <h3 class="dashboard__title">Nos Enchères Perdus</h3>
    <v-container fluid>
      <BidTable v-bind:myBids="true" v-bind:lostBills="true" />
    </v-container>
  </div>
</template>

<script>
import BidTable from "../components/BidTable";

export default {
  name: "LostBills",
  components: {
    BidTable
  },
  data: () => ({
    interval: null
  }),
  computed: {
    allBills() {
      return this.$store.getters.LostBills;
    }
  },
  channels: {
    update_bills_channel: {
      received() {
        this.$store.dispatch("GET_LOST_BILLS");
      }
    }
  },
  mounted() {
    this.$store.dispatch("GET_LOST_BILLS");
    this.$cable.subscribe(
      { channel: "UpdateBillsChannel" },
      "update_bills_channel"
    );
  }
};
</script>
