<template>
  <div>
    <div class='form-title'>
      <h4>Etape 3/3</h4>
      <p>Renseignez vos informations personnelles et créer une enchère</p>
      <v-container fluid>
        <v-layout row wrap>
          <v-flex xs12 sm8 offset-sm-2 id='form-fields' class='compact-form'>
            <div >
              <div class="form-subtitle inline-div">Vous êtes un particulier?</div>
              <div class="form-content inline-div">
                  <v-switch :label="booleanToString(particulier_q)" v-model="particulier_q" color='success'></v-switch>
              </div>
            </div>

            <div v-if='particulier_q'>
              <div class="form-subtitle inline-div">Nom</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="last_name" outline />
              </div>
            </div>

            <div v-if='particulier_q'>
              <div class="form-subtitle inline-div">Prénom</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="first_name" outline />
              </div>
            </div>

            <div v-if='!particulier_q'>
              <div class="form-subtitle inline-div">Raison sociale</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="company" outline />
              </div>
            </div>

            <div >
              <div class="form-subtitle inline-div">Numéro de Téléphone</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="phone" outline />
              </div>
            </div>

            <div >
              <div class="form-subtitle inline-div">Email</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="email" outline />
              </div>
            </div>


          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </div>
</template>

<script>
  import {required} from '../../shared_components/validate'


  export default {
    name: 'BillFormStep3',
    data: () => ({
      required: required,
      last_name: null,
      first_name: null,
      phone: null,
      email: null,
      company: null,
      particulier_q: true,
    }),
    computed: {
      client() {
        return this.$store.getters.Client
      }
    },
    methods: {
      booleanToString(param) {
        if(param) return 'Oui'
        if(!param) return 'Non'
      }
    },
    mounted() {
      this.last_name = this.client.attributes.last_name
      this.first_name = this.client.attributes.first_name
      this.phone = this.client.attributes.phone_number
      this.email = this.client.attributes.email
      this.company = this.client.attributes.company
    }
  }
</script>


