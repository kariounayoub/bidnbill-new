<template>
  <div>
    <!-- Dialog -->
    <v-dialog v-model="dialog" max-width="700px" v-if="viewedBill">
      <BidDialog v-bind:viewedBill="viewedBill" v-bind:canBid="!myBids" v-on:close="close" />
    </v-dialog>

    <!-- Main Table -->
    <v-card class="rounded">
      <v-layout row wrap v-if="myBids && !lostBills">
        <v-flex xs12 sm4 offset-sm-4>
          <v-switch
            v-model="showMyBids"
            color="primary"
            label="Seulement mes enchères"
            center
            class="justify-center"
          ></v-switch>
        </v-flex>
      </v-layout>
      <v-layout row wrap class="inside-card">
        <v-flex xs12 sm4>
          <v-select
            class="with-margin"
            :items="categories"
            label="Demande"
            @change="filterDemandes"
          ></v-select>
        </v-flex>
        <v-flex xs12 sm4>
          <v-text-field
            class="with-margin"
            append-icon="search"
            label="Ville"
            single-line
            hide-details
            @input="filterVilles"
          ></v-text-field>
        </v-flex>
        <v-flex xs12 sm4>
          <v-select
            class="with-margin"
            :items="providers"
            label="Fournisseurs"
            @change="filterFournisseurs"
          ></v-select>
        </v-flex>
        <v-flex xs12>
          <v-data-table
            :headers="headers"
            :items="items"
            item-key="title"
            :rows-per-page-items="[10,25,50,100]"
            rows-per-page-text="Résultats par page"
            must-sort
            :search="filters"
            :custom-filter="customFilter"
            :no-data-text="'Données indisponibles'"
            id="my-datatable"
          >
            <template v-slot:items="props">
              <tr>
                <td class="text-xs-left">{{ props.item.category.name }}</td>
                <td class="text-xs-right">{{ props.item.current_provider }}</td>
                <td class="text-xs-right">{{ props.item.standardized_price }} €</td>
                <td class="text-xs-right">{{ props.item.city }}</td>
                <td class="text-xs-center status-width large">
                  <span
                    class="status-tag"
                    v-bind:class="statusClass(props.item)"
                  >{{ statusCalc(props.item) }}</span>
                </td>
                <td class="text-xs-right">
                  <v-icon @click="viewBill(props.item)">visibility</v-icon>
                </td>
              </tr>
            </template>
          </v-data-table>
        </v-flex>
      </v-layout>
    </v-card>
  </div>
</template>

<script>
import BidDialog from "./BidDialog";
import providers from "../../shared_components/providers";

export default {
  name: "BidTable",
  props: { myBids: Boolean, lostBills: { type: Boolean, default: false } },
  components: {
    BidDialog
  },
  data: () => ({
    filters: {
      ville: "",
      demande: "",
      fournisseur: ""
    },
    categories: ["Tout", "Electricité", "Gaz", "Electricité et Gaz"],
    providers: ["Tout", ...providers],
    dialog: false,
    headers: [
      { text: "Type de Contrat", align: "left", value: "category" },
      { text: "Fournisseur actuel", value: "current_provider", align: "right" },
      {
        text: "Prix",
        value: "standardized_price",
        align: "right"
      },
      { text: "Ville", value: "city", align: "right" },
      { text: "Statut", value: "status", align: "center" },
      { text: "Actions", value: "actions", align: "right" }
    ],
    viewedBill: null,
    showMyBids: false
  }),
  computed: {
    bills() {
      if (this.lostBills) return this.$store.getters.LostBills;
      if (this.myBids && this.showMyBids) return this.$store.getters.MyBills;
      if (this.myBids) return this.$store.getters.AccountBills;
      if (!this.myBids) return this.$store.getters.OtherBills;
    },
    items() {
      return this.bills.map(e => e.attributes);
    },
    provider() {
      return this.$store.getters.Provider.attributes;
    }
  },
  watch: {
    dialog(val) {
      val || this.close();
    }
  },
  methods: {
    statusCalc(bill) {
      if (this.lostBills) return "Enchère perdu";
      if (this.myBids) {
        const myBid = bill.bids.find(
          b => b.account.id === this.provider.account.id
        );
        if (myBid.bid.needs_editing) return "Le client à modifier son enchère";
      }
      let length = 0;
      if (bill.bids) {
        length = bill.bids.length;
      }
      return `${length} enchères en cours`;
    },
    statusClass(bill) {
      if (this.lostBills) return "error";
      if (this.myBids) {
        const myBid = bill.bids.find(
          b => b.account.id === this.provider.account.id
        );
        if (myBid.bid.needs_editing) return "warning";
      }
    },
    customFilter(items, filters, filter, headers) {
      const cf = new this.$MultiFilters(items, filters, filter, headers);

      cf.registerFilter("ville", function(searchWord, items) {
        if (searchWord.trim() === "") return items;

        return items.filter(item => {
          if (item.city === null) return "";
          return item.city.toLowerCase().includes(searchWord.toLowerCase());
        }, searchWord);
      });

      cf.registerFilter("demande", function(demande, items) {
        if (demande.trim() === "") return items;
        if (demande.trim() === "Tout") return items;

        return items.filter(item => {
          return item.category.name.toLowerCase() === demande.toLowerCase();
        }, demande);
      });

      cf.registerFilter("fournisseur", function(fournisseur, items) {
        if (fournisseur.trim() === "") return items;
        if (fournisseur.trim() === "Tout") return items;

        return items.filter(item => {
          return (
            item.current_provider.toLowerCase() === fournisseur.toLowerCase()
          );
        }, fournisseur);
      });

      return cf.runFilters();
    },
    filterVilles(val) {
      this.filters = this.$MultiFilters.updateFilters(this.filters, {
        ville: val
      });
    },
    filterDemandes(val) {
      this.filters = this.$MultiFilters.updateFilters(this.filters, {
        demande: val
      });
    },
    filterFournisseurs(val) {
      this.filters = this.$MultiFilters.updateFilters(this.filters, {
        fournisseur: val
      });
    },
    viewBill(item) {
      this.viewedBill = Object.assign({}, item);
      this.dialog = true;
    },
    close() {
      this.dialog = false;
      this.viewedBill = null;
    }
  }
};
</script>

<style scoped lang="scss">
.inside-card {
  padding: 20px;
}
.with-margin {
  margin: 0 15px;
}
</style>
