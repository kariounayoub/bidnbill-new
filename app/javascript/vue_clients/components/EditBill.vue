<template>
  <div>
    <v-card class='rounded'>
      <v-form ref="form" v-model="valid" lazy-validation>
        <v-card-title class="headline">
          <span >Modifier</span>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex xs12>
                  <v-select v-model="current_provider" :items="listProviders"  label='Fournisseur Actuel' :rules="[required]" ></v-select>

                  <v-text-field v-model="frequency"  label='Fréquence de paiement' />

                  <AddressAutocomplete v-model='address' v-bind:initAddress='initialAddress' v-on:changeCity='changeCity'/>

                  <v-text-field v-model="price"  label='Prix' :rules="[required, number]" />

                  <v-text-field v-model="consumption" label='Consommation Annuelle (kWh)' :rules="[required, number]" />

              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="success darken-1" flat @click="$emit('close')">Fermer</v-btn>
          <v-btn color="success darken-1" flat @click="editBill()">Enregistrer</v-btn>
        </v-card-actions>
      </v-form>
    </v-card>
  </div>
</template>

<script>
  import {required, number} from '../../shared_components/validate'
  import providers from '../../shared_components/providers'
  import AddressAutocomplete from './AddressAutocomplete'

  export default {
    name: 'EditBill',
    components: {
      AddressAutocomplete
    },
    data: () => ({
      required: required, number: number,
      valid: false,
      current_provider: null,
      frequency: null,
      price: null,
      address: null,
      consumption: null,
      listProviders: providers,
      city: null,
    }),
    computed: {
      activeBill() {
        return this.$store.getters.ActiveBill
      },
      initialAddress() {
        return this.activeBill.attributes.address
      }
    },
    methods: {
      changeCity(v) {
        this.city = v
      },
      editBill() {
        if (this.$refs.form.validate()) {
          const formData = {
              bill_id: this.activeBill.attributes.id,
              bill: {
                price: this.price,
                current_provider: this.current_provider,
                consumption: this.consumption,
                address: this.address,
                city: this.city
              }
          }
          this.$emit('close')
          this.$store.dispatch('UPDATE_BILL', formData)
        }
      }
    },
    mounted() {
      this.current_provider = this.activeBill.attributes.current_provider
      this.price = this.activeBill.attributes.price
      this.consumption = this.activeBill.attributes.consumption
    }
  }
</script>
