<template>
  <div>
    <h3 class="dashboard__title">Nos Enchères</h3>
    <v-container fluid>
      <BidTable v-bind:myBids="true" />
    </v-container>
  </div>
</template>

<script>
import BidTable from "../components/BidTable";

export default {
  name: "ProviderEncheres",
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
  channels: {
    update_bills_channel: {
      received() {
        this.$store.dispatch("GET_BILLS");
      }
    }
  },
  mounted() {
    this.$store.dispatch("GET_BILLS");
    this.$cable.subscribe(
      { channel: "UpdateBillsChannel" },
      "update_bills_channel"
    );
  }
};
</script>
