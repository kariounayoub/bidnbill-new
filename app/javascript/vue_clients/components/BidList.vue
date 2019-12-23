<template>
  <div>
    <v-card class="user_card rounded">
      <div class="card__title">Mes offres</div>
      <v-data-table
        id="my-datatable"
        :headers="headers"
        :items="bids"
        :rows-per-page-text="'Résultats par page'"
        :no-data-text="'Aucune donnée disponible'"
        :rows-per-page-items="[5, 10, 25, { text: 'Tout', value: -1 }]"
      >
        <template v-slot:items="props">
          <td class="text-xs-left">{{ props.item.account.company }}</td>
          <td class="text-xs-left">{{ props.item.bid.price }} € / mois</td>
          <td class="text-xs-left">
            {{ calculateDifference(props.item.bid.price) }} € / mois
          </td>
          <td class="text-xs-center status-width">
            <span
              class="status-tag"
              v-bind:class="statusClass(props.item.bid.status)"
              >{{ props.item.bid.status }}</span
            >
          </td>
          <td class="text-xs-center">
            <v-icon
              @click="viewBid(props.item.bid)"
              v-if="
                activeBill.attributes.is_open && !props.item.bid.needs_editing
              "
              >visibility</v-icon
            >
            <span
              v-if="
                props.item.bid.needs_editing && activeBill.attributes.is_open
              "
              >En attente de validation suite à votre modification</span
            >
          </td>
        </template>
      </v-data-table>
    </v-card>

    <v-dialog v-model="dialog" max-width="700px">
      <ActionsDialog
        v-on:close="dialog = false"
        v-on:validate="selectBid"
        v-bind:price="viewedBid.price"
        v-bind:text="viewedBid.content"
      />
    </v-dialog>
  </div>
</template>

<script>
import ActionsDialog from "./ActionsDialog";
export default {
  name: "BidList",
  props: ["bids"],
  components: {
    ActionsDialog
  },
  data: () => ({
    dialog: false,
    viewedBid: { price: null, content: null },
    headers: [
      { text: "Fournisseur", value: "account.company", class: "bid__header" },
      { text: "Offre", value: "bid.price", class: "bid__header" },
      { text: "Economies", value: "savings", class: "bid__header" },
      {
        text: "Statut",
        value: "bid.status",
        class: "bid__header",
        align: "center"
      },
      { text: "Actions", value: "actions", class: "bid__header" }
    ]
  }),
  computed: {
    activeBill() {
      return this.$store.getters.ActiveBill;
    }
  },
  methods: {
    calculateDifference(bidPrice) {
      return this.activeBill.attributes.standardized_price - bidPrice;
    },
    selectBid(response) {
      const formData = {
        id: this.viewedBid.id,
        bid: {
          methode_contact: response
        }
      };
      this.$store.dispatch("SELECT_BID", formData);
    },
    statusClass(status) {
      if (status === "refusé") return "error";
      if (status === "en attente") return "warning";
      if (status === "accépté") return "success";
    },
    viewBid(item) {
      this.viewedBid = Object.assign({}, item);
      this.dialog = true;
    }
  }
};
</script>
