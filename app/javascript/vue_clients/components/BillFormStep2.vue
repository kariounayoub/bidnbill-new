<template>
  <div>
    <div class='form-title'>
      <h4>Etape 2/3</h4>
      <p>Téléchargez votre facture ou remplissez le formulaire de consommation</p>
      <v-container fluid>
        <v-layout row wrap>
          <v-flex xs12 sm4>
            <div class='upload-invoice-wrapper'>
              <div class="flex-center flex-column"   >
                <div class="download-icon" >
                  <i class="fas fa-file-invoice"></i>
                </div>
                <p>Téléchargez Facture</p>
              </div>
            </div>
          </v-flex>
          <v-flex xs12 sm8 id='form-fields' class='compact-form'>
            <div >
              <div class="form-subtitle inline-div">Vôtre fournisseur actuel</div>
              <div class="form-content inline-div">
                  <v-select v-model="current_provider" :items="listProviders" outline :rules="[required]" ></v-select>
              </div>
            </div>

            <div >
              <div class="form-subtitle inline-div">Fréquence de paiement</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="frequency" outline />
              </div>
            </div>

            <div >
              <div class="form-subtitle inline-div">Prix TTC</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="price" outline :rules="[required, number]" />
              </div>
            </div>

            <div >
              <div class="form-subtitle inline-div">Votre addresse</div>
              <div class="form-content inline-div">
                  <v-combobox
                    v-model="address"
                    :items="items"
                    :search-input.sync="search"
                    hide-no-data
                    hide-selected
                    outline
                    :rules="[required]"
                  ></v-combobox>
              </div>
            </div>

            <div >
              <div class="form-subtitle inline-div">Connaissez vous votre consommation?</div>
              <div class="form-content inline-div">
                  <v-switch :label="booleanToString(consumption_q)" v-model="consumption_q" color='success'></v-switch>
              </div>
            </div>

            <div v-if='consumption_q'>
              <div class="form-subtitle inline-div">Consommation annuelle (KW/h)</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="consumption" outline :rules="[required, number]" />
              </div>
            </div>

          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import {required, number} from '../../shared_components/validate'
  import providers from '../../shared_components/providers'

  export default {
    name: 'BillFormStep2',
    data: () => ({
      required: required, number: number,
      current_provider: null,
      frequency: null,
      price: null,
      address: null,
      address2: null,
      consumption: null,
      consumption_q: true,
      listProviders: providers,
      search: false,
      entries: [],
      city: null,
    }),
    computed: {
      items () {
        return this.entries.map(e => e.properties.label)
      }
    },
    methods: {
      booleanToString(param) {
        if(param) return 'Oui'
        if(!param) return 'Non'
      }
    },
   watch: {
    search (val) {
      // Lazily load input items
      axios.get(`https://api-adresse.data.gouv.fr/search/?q=${val}`)
        .then(res => {
          this.entries = res.data.features
          this.city = this.entries[0].properties.city
        })
        .catch(err => {
          console.log(err)
        })
        .finally(() => (this.isLoading = false))
      }
    }
  }
</script>


<style scoped lang='scss'>
  .upload-invoice-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
    border-right: 2px solid var(--v-success-base);
    font-size: 16px;
    font-weight: 700;
    color: rgba(0,0,0,0.8);
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
    color: var(--v-success-base);
    border: 2px solid var(--v-success-base);
    margin-bottom: 5px;
    i {
      font-size: 60px;
    }
  }

  @media only screen and (max-width: 600px) {
    .upload-invoice-wrapper {
      border: none;
    }

  }
</style>
