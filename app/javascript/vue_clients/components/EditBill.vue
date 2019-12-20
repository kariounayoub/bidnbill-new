<template>
  <div>
    <v-card class="rounded">
      <v-card-title class="headline">
        <span>Modifier</span>
      </v-card-title>
      <v-form ref="form" v-model="valid" lazy-validation>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex xs12>
                <v-select
                  v-model="current_provider"
                  :items="listProviders"
                  label="Fournisseur Actuel"
                  :rules="[required]"
                ></v-select>

                <v-select
                  v-model="payment_frequency"
                  label="Fréquence de paiement"
                  :rules="[required]"
                  :items="listFrequency"
                ></v-select>

                <AddressAutocomplete
                  v-model="address"
                  v-bind:initAddress="initialAddress"
                  v-on:changeCity="changeCity"
                />

                <v-text-field
                  v-model="price"
                  label="Prix"
                  :rules="[required, number]"
                />

                <v-text-field
                  v-model="consumption"
                  label="Consommation Annuelle (kWh)"
                  :rules="[required, number]"
                />

                <v-switch
                  :label="booleanToString(pdl_q)"
                  v-model="pdl_q"
                  color="primary"
                  label="Connaissez vous votre numéro de PDL?"
                ></v-switch>

                <v-text-field
                  v-model="pdl"
                  label="Numéro de PDL"
                  v-if="pdl_q"
                />

                <v-switch
                  :label="booleanToString(energie_verte)"
                  v-model="energie_verte"
                  color="primary"
                  label="Je ne recherche que des offres d’énergies vertes?"
                ></v-switch>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary darken-1" flat @click="$emit('close')"
            >Fermer</v-btn
          >
          <v-btn color="primary darken-1" flat @click="dialog2 = true"
            >Enregistrer</v-btn
          >
        </v-card-actions>
      </v-form>
    </v-card>

    <!-- Second Dialog With Form -->
    <v-dialog v-model="dialog2" max-width="500px">
      <AlertDialog
        v-on:validate="editBill"
        v-on:close="dialog2 = false"
        v-bind:text="
          'Si vous faites des modifications les offres en cours doivent être validé par les fournisseurs'
        "
      />
    </v-dialog>
  </div>
</template>

<script>
import { required, number } from "../../shared_components/validate";
import providers from "../../shared_components/providers";
import AlertDialog from "../../shared_components/AlertDialog";
import AddressAutocomplete from "./AddressAutocomplete";

export default {
  name: "EditBill",
  components: {
    AddressAutocomplete,
    AlertDialog
  },
  data: () => ({
    required: required,
    number: number,
    valid: false,
    current_provider: null,
    payment_frequency: null,
    price: null,
    address: null,
    consumption: null,
    listProviders: providers,
    listFrequency: ["mensuelle", "semestrielle", "annuelle"],
    city: null,
    pdl_q: null,
    pdl: null,
    energie_verte: null,
    dialog2: false
  }),
  computed: {
    activeBill() {
      return this.$store.getters.ActiveBill;
    },
    initialAddress() {
      return this.activeBill.attributes.address;
    }
  },
  methods: {
    changeCity(v) {
      this.city = v;
    },
    editBill() {
      if (this.$refs.form.validate()) {
        const formData = {
          bill_id: this.activeBill.attributes.id,
          bill: {
            price: this.price,
            current_provider: this.current_provider,
            payment_frequency: this.payment_frequency,
            consumption: this.consumption,
            pdl: this.pdl,
            energie_verte: this.energie_verte,
            address: this.address,
            city: this.city
          }
        };
        this.$emit("close");
        this.$store.dispatch("UPDATE_BILL", formData);
      }
    },
    booleanToString(param) {
      if (param) return "Oui";
      if (!param) return "Non";
    }
  },
  mounted() {
    this.current_provider = this.activeBill.attributes.current_provider;
    this.price = this.activeBill.attributes.price;
    this.consumption = this.activeBill.attributes.consumption;
    this.address = this.activeBill.attributes.address;
    this.city = this.activeBill.attributes.city;
    this.payment_frequency = this.activeBill.attributes.payment_frequency;
    this.pdl = this.activeBill.attributes.pdl;
    this.energie_verte = this.activeBill.attributes.energie_verte;
    this.pdl_q = !(this.activeBill.attributes.pdl === null);
  }
};
</script>

<style scoped lang="scss">
.icon-danger {
  font-size: 70px;
  color: var(--v-error-base);
}

.heading-danger {
  font-weight: bold;
  color: rgba(0, 0, 0, 0.8);
}

h3.heading-danger {
  font-size: 20px;
}
h4.heading-danger {
  font-size: 16px;
}

.padded-card {
  padding: 20px 0px;
}
</style>
