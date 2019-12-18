<template>
  <div>
    <div class="form-title">
      <h4>Etape 2/2</h4>
      <p>Nous avons besoin de quelques informations pour créer votre enchère</p>
      <v-container fluid>
        <v-layout row wrap>
          <!--           <v-flex xs12 sm4>
            <div class='upload-invoice-wrapper'>
              <div class="flex-center flex-column"   >
                <div class="download-icon" >
                  <i class="fas fa-file-invoice"></i>
                </div>
                <p>Téléchargez Facture</p>
              </div>
            </div>
          </v-flex>-->
          <v-flex xs12 sm8 offset-sm-2 class="form-fields compact-form">
            <div>
              <div class="form-subtitle inline-div">Vôtre fournisseur actuel</div>
              <div class="form-content inline-div">
                <v-select
                  v-model="current_provider"
                  :items="listProviders"
                  outline
                  :rules="[required]"
                ></v-select>
              </div>
            </div>

            <div>
              <div class="form-subtitle inline-div">Fréquence de paiement</div>
              <div class="form-content inline-div">
                <v-select
                  v-model="payment_frequency"
                  outline
                  :rules="[required]"
                  :items="listFrequency"
                ></v-select>
              </div>
            </div>

            <div>
              <div class="form-subtitle inline-div">Prix TTC</div>
              <div class="form-content inline-div">
                <v-text-field v-model="price" outline :rules="[required, number]" />
              </div>
            </div>

            <div>
              <div class="form-subtitle inline-div">Votre addresse</div>
              <div class="form-content inline-div">
                <AddressAutocomplete
                  v-model="address"
                  v-bind:outlined="true"
                  v-bind:Label="null"
                  v-on:changeCity="changeCity"
                />
              </div>
            </div>

            <div>
              <div class="form-subtitle inline-div">Connaissez vous votre consommation?</div>
              <div class="form-content inline-div">
                <div class="flex-center">
                  <v-switch
                    :label="booleanToString(consumption_q)"
                    v-model="consumption_q"
                    color="primary"
                  ></v-switch>
                  <v-btn
                    color="primary lighten-1"
                    flat
                    @click="dialog = true"
                    v-if="!consumption_q"
                  >Afficher Formulaire</v-btn>
                </div>
              </div>
            </div>

            <div>
              <div class="form-subtitle inline-div">Consommation annuelle (kWh)</div>
              <div class="form-content inline-div">
                <v-text-field
                  v-model="consumption"
                  outline
                  :rules="[required, number]"
                  :disabled="!consumption_q"
                />
              </div>
              <div class="form-subtitle inline-div">
                Connaissez vous votre numéro de PDL?
                <i
                  class="fas fa-info-circle"
                  title="info"
                  v-on:click="dialog2 = true"
                ></i>
              </div>
              <div class="form-content inline-div">
                <div class="flex-center">
                  <v-switch :label="booleanToString(pdl_q)" v-model="pdl_q" color="primary"></v-switch>
                </div>
              </div>
              <div class="form-subtitle inline-div" v-if="pdl_q">Numéro de PDL</div>
              <div class="form-content inline-div" v-if="pdl_q">
                <v-text-field v-model="pdl" outline :rules="[required, number]" />
              </div>
              <div
                class="form-subtitle inline-div"
              >Je ne recherche que des offres d’énergies vertes?</div>
              <div class="form-content inline-div">
                <div class="flex-center">
                  <v-switch
                    :label="booleanToString(energie_verte)"
                    v-model="energie_verte"
                    color="primary"
                  ></v-switch>
                </div>
              </div>
            </div>
          </v-flex>
        </v-layout>
      </v-container>
    </div>

    <v-dialog v-model="dialog" max-width="700px" v-if="!consumption_q" v-on:close="dialog = false">
      <ConsumptionFormDialog
        v-on:close="close"
        v-on:calculation="consumptionCalc"
        v-on:consumptionData="updateConsumptionData"
      />
    </v-dialog>
    <v-dialog v-model="dialog2" max-width="500px">
      <InfoDialog
        v-on:close="dialog2 = false"
        v-bind:title="'Point de Livraison (PDL)'"
        v-bind:text="'Le point de livraison ou PDL est votre identifiant de compteur électrique. Vous le trouverez sur toute vos factures d’énergie'"
      />
    </v-dialog>
  </div>
</template>

<script>
import axios from "axios";
import { required, number } from "../../shared_components/validate";
import providers from "../../shared_components/providers";
import AddressAutocomplete from "./AddressAutocomplete";
import ConsumptionFormDialog from "./ConsumptionFormDialog";
import InfoDialog from "../../shared_components/InfoDialog";

export default {
  name: "BillFormStep2",
  components: {
    AddressAutocomplete,
    ConsumptionFormDialog,
    InfoDialog
  },
  data: () => ({
    required: required,
    number: number,
    current_provider: null,
    payment_frequency: null,
    price: null,
    address: null,
    consumption: null,
    consumption_q: true,
    listProviders: providers,
    listFrequency: ["mensuelle", "semestrielle", "annuelle"],
    city: null,
    consumptionData: null,
    pdl_q: false,
    pdl: null,
    energie_verte: false,
    dialog: false,
    dialog2: false
  }),
  methods: {
    changeCity(v) {
      this.city = v;
    },
    booleanToString(param) {
      if (param) return "Oui";
      if (!param) return "Non";
    },
    close() {
      this.dialog = false;
    },
    updateConsumptionData(v) {
      this.consumptionData = v;
    },
    consumptionCalc(v) {
      this.consumption = v;
    }
  },
  watch: {
    dialog(val) {
      val || this.close();
    },
    consumption_q() {
      this.consumption_q ? (this.dialog = false) : (this.dialog = true);
      if (this.consumption_q) {
        this.consumption = 0;
        this.consumptionData = null;
      }
    }
  }
};
</script>


<style scoped lang='scss'>
.upload-invoice-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  border-right: 2px solid var(--v-primary-base);
  font-size: 16px;
  font-weight: 700;
  color: rgba(0, 0, 0, 0.8);
  padding-bottom: 20px;
}

.download-icon {
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 120px;
  height: 120px;
  border-radius: 5%;
  color: var(--v-primary-base);
  border: 2px solid var(--v-primary-base);
  margin-bottom: 5px;
  i {
    font-size: 60px;
  }
}

i {
  color: var(--v-primary-base);
  font-size: 20px;
  margin-left: 5px;
  cursor: pointer;
  &:hover {
    color: inherit;
  }
}

@media only screen and (max-width: 600px) {
  .upload-invoice-wrapper {
    border: none;
  }
}
</style>
