<template>
  <div>
    <!-- Main Dialog -->
    <v-card class="rounded">
      <v-card-title class="headline">
        <span>Détail de l'enchère</span>
      </v-card-title>

      <v-card-text class="card-info">
        <div>
          <div class="info-title inline-div">Type de Contrat</div>
          <div class="content inline-div">{{ viewedBill.category.name }}</div>
        </div>
        <div>
          <div class="info-title inline-div">Fournisseur Actuel</div>
          <div class="content inline-div">
            {{ viewedBill.current_provider }}
          </div>
        </div>
        <div>
          <div class="info-title inline-div">Prix</div>
          <div class="content inline-div">
            {{ viewedBill.standardized_price }} €/ mois
          </div>
        </div>
        <div>
          <div class="info-title inline-div">
            Consommation
            <span v-if="viewedBill.calculated_consumption">(estimée)</span>
          </div>
          <div class="content inline-div">{{ viewedBill.consumption }} kWh</div>
        </div>
        <div>
          <div class="info-title inline-div">Ville</div>
          <div class="content inline-div">{{ viewedBill.city }}</div>
        </div>
        <div>
          <div
            class="info-title inline-div green-text"
            v-if="viewedBill.energie_verte"
          >
            Energie verte seulement
          </div>
          <div class="content inline-div">
            <v-btn color="primary" @click="dialog3 = true">
              Informations Supplémentaires
            </v-btn>
          </div>
        </div>
        <v-spacer></v-spacer>
        <v-divider></v-divider>
        <h5 class="text-center bold">Enchères en cours</h5>
        <v-data-table
          :headers="bidHeaders"
          :items="viewedBill.bids"
          item-key="title"
          :rows-per-page-items="[5, 10]"
          rows-per-page-text="Résultats par page"
          no-data-text="Données indisponibles"
        >
          <template v-slot:items="props">
            <tr>
              <td class="text-xs-left">{{ props.item.account.company }}</td>
              <td class="text-xs-right">{{ props.item.bid.price }} €/ mois</td>
              <td class="text-xs-center">
                <span
                  class="status-tag"
                  v-bind:class="statusClass(props.item.bid.status)"
                  >{{ props.item.bid.status }}</span
                >
              </td>
            </tr>
          </template>
        </v-data-table>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="primary darken-1" flat @click="$emit('close')"
          >Fermer</v-btn
        >
        <v-btn
          color="primary darken-1"
          flat
          @click="dialog2 = true"
          v-if="canBid"
          >Enchérir</v-btn
        >
        <v-btn
          color="primary darken-1"
          flat
          @click="dialog2 = true"
          v-if="myBidNeedsEditing()"
          >Modifier</v-btn
        >
      </v-card-actions>
    </v-card>

    <!-- Second Dialog With Form -->
    <v-dialog
      v-model="dialog2"
      max-width="600px"
      v-if="canBid || myBidNeedsEditing()"
    >
      <BiddingForm
        v-bind:canBid="canBid"
        v-bind:myBidNeedsEditing="myBidNeedsEditing"
        v-bind:myBid="myBid"
        v-bind:viewedBill="viewedBill"
        v-on:close="handleClose()"
        v-on:closeAll="$emit('close')"
      />
    </v-dialog>

    <!-- Third Dialog With Bill Info -->
    <v-dialog v-model="dialog3" max-width="600px">
      <BillInfo v-bind:viewedBill="viewedBill" v-on:close="handleClose()" />
    </v-dialog>
  </div>
</template>

<script>
import BiddingForm from "./BiddingForm";
import BillInfo from "./BillInfo";
export default {
  name: "BidDialog",
  props: ["viewedBill", "canBid"],
  components: {
    BiddingForm,
    BillInfo
  },
  data: () => ({
    bidHeaders: [
      { text: "Fournisseur", align: "left", value: "account.company" },
      { text: "Prix", value: "bid.price", align: "right" },
      { text: "Statut", value: "status", align: "center" }
    ],
    dialog2: false,
    dialog3: false
  }),
  computed: {
    provider() {
      return this.$store.getters.Provider.attributes;
    },
    myBid() {
      if (!this.canBid) {
        return this.viewedBill.bids.find(
          b => b.account.id === this.provider.account.id
        );
      }
      return null;
    }
  },
  methods: {
    myBidNeedsEditing() {
      if (!this.canBid) {
        if (this.myBid.bid.needs_editing) return true;
      }
      return false;
    },
    statusClass(status) {
      if (status === "refusé") return "error";
      if (status === "en attente") return "warning";
      if (status === "accépté") return "primary";
    },
    handleClose() {
      this.dialog2 = false;
      this.dialog3 = false;
    }
  }
};
</script>
