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
          <div class="content inline-div">{{viewedBill.category.name}}</div>
        </div>
        <div>
          <div class="info-title inline-div">Fournisseur Actuel</div>
          <div class="content inline-div">{{viewedBill.current_provider}}</div>
        </div>
        <div>
          <div class="info-title inline-div">Prix</div>
          <div class="content inline-div">{{viewedBill.standardized_price}} €/ mois</div>
        </div>
        <div>
          <div class="info-title inline-div">
            Consommation
            <span v-if="viewedBill.calculated_consumption">(estimée)</span>
          </div>
          <div class="content inline-div">{{viewedBill.consumption}} kWh</div>
        </div>
        <div>
          <div class="info-title inline-div">Ville</div>
          <div class="content inline-div">{{viewedBill.city}}</div>
        </div>
        <!--           <div v-if='viewedBill.calculated_consumption'><div class="info-title inline-div">Type Logement</div><div class="content inline-div">{{viewedBill.type_home}}</div></div>
          <div v-if='viewedBill.calculated_consumption'><div class="info-title inline-div">Nombre d'habitants</div><div class="content inline-div">{{viewedBill.nb_people}} personnes</div></div>
          <div v-if='viewedBill.calculated_consumption'><div class="info-title inline-div">Surface</div><div class="content inline-div">{{viewedBill.surface}} m2</div></div>
          <div v-if='viewedBill.calculated_consumption'><div class="info-title inline-div">Chauffage</div><div class="content inline-div">{{viewedBill.heating}}</div></div>
        <div v-if='viewedBill.calculated_consumption'><div class="info-title inline-div">Eau chaude</div><div class="content inline-div">{{viewedBill.hot_water}}</div></div>-->
        <v-spacer></v-spacer>
        <v-divider></v-divider>
        <h5 class="text-center bold">Enchères en cours</h5>
        <v-data-table
          :headers="bidHeaders"
          :items="viewedBill.bids"
          item-key="title"
          :rows-per-page-items="[5,10]"
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
                >{{ props.item.bid.status }}</span>
              </td>
            </tr>
          </template>
        </v-data-table>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="primary darken-1" flat @click="$emit('close')">Fermer</v-btn>
        <v-btn color="primary darken-1" flat @click="dialog2 = true" v-if="canBid">Enchérir</v-btn>
        <v-btn
          color="primary darken-1"
          flat
          @click="dialog2 = true"
          v-if="myBidNeedsEditing()"
        >Modifier</v-btn>
      </v-card-actions>
    </v-card>

    <!-- Second Dialog With Form -->
    <v-dialog v-model="dialog2" max-width="500px" v-if="canBid || myBidNeedsEditing()">
      <v-card class="rounded">
        <v-form ref="form" v-model="valid" lazy-validation>
          <v-card-title class="headline">
            <span>Enchérir</span>
          </v-card-title>
          <v-card-text>
            <v-container grid-list-md>
              <v-layout wrap>
                <v-flex xs12>
                  <v-text-field
                    label="Prix (mensuelle)"
                    v-model="price"
                    :rules="[required, number]"
                  ></v-text-field>
                </v-flex>
                <v-flex xs12>
                  <v-textarea label="Présentation de l'offre" v-model="content"></v-textarea>
                </v-flex>
              </v-layout>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary darken-1" flat @click="dialog2 = false">Fermer</v-btn>
            <v-btn
              color="primary darken-1"
              flat
              v-if="canBid"
              @click="saveBid('create')"
            >Enregistrer</v-btn>
            <v-btn
              color="primary darken-1"
              flat
              v-if="myBidNeedsEditing()"
              @click="saveBid('edit')"
            >Enregistrer</v-btn>
          </v-card-actions>
        </v-form>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { required, number } from "../../shared_components/validate";
export default {
  name: "BidDialog",
  props: ["viewedBill", "canBid"],
  data: () => ({
    required: required,
    number: number,
    valid: false,
    price: null,
    content: null,
    bidHeaders: [
      { text: "Fournisseur", align: "left", value: "account.company" },
      { text: "Prix", value: "bid.price", align: "right" },
      { text: "Statut", value: "status", align: "center" }
    ],
    dialog2: false
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
    saveBid(type) {
      if (this.$refs.form.validate()) {
        const formData = {
          bid: {
            bill_id: this.viewedBill.id,
            price: this.price,
            content: this.content,
            user_id: this.$store.getters.Provider.attributes.id
          }
        };
        this.dialog2 = false;
        this.$emit("close");
        if (type === "create") {
          this.$store.dispatch("CREATE_BID", formData);
        }
        if (type === "edit") {
          formData.bid_id = this.myBid.bid.id;
          this.$store.dispatch("UPDATE_BID", formData);
        }
      }
    }
  },
  mounted() {
    if (!this.canBid) {
      this.price = this.myBid.bid.price;
      this.content = this.myBid.bid.content;
    }
  }
};
</script>

