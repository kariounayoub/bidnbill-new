<template>
  <div>
    <h3 class="dashboard__title">Nos Clients</h3>
    <v-container fluid>
      <v-layout row wrap class="inside-card">
        <v-flex xs12 sm12 v-if="!activeClient">
          <ClientTable v-bind:clients="myClients" />
        </v-flex>
        <v-flex xs12 sm8 v-if="activeClient">
          <ClientTable v-bind:clients="myClients" />
        </v-flex>
        <v-flex xs12 sm4>
          <ClientCard v-if="activeClient" v-bind:client="activeClient" />
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import ClientTable from "../components/ClientTable";
import ClientCard from "../components/ClientCard";

export default {
  name: "ProviderClients",
  components: {
    ClientTable,
    ClientCard
  },
  data: () => ({
    interval: null
  }),
  computed: {
    myClients() {
      return this.$store.getters.MyClients;
    },
    activeClient() {
      return this.$store.getters.ActiveClient;
    }
  },
  channels: {
    update_bill_channel: {
      received() {
        this.$store.dispatch("GET_MY_CLIENTS");
      }
    }
  },
  mounted() {
    this.$store.dispatch("GET_MY_CLIENTS");
    this.$cable.subscribe(
      {
        channel: "UpdateBillChannel",
        account_id: this.$store.getters.Account.attributes.id
      },
      "update_bill_channel"
    );
  }
};
</script>
