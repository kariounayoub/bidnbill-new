<template>
 <div>
  <!-- Main Dialog -->
  <v-card class=' rounded'>
    <v-card-title class="headline">
      <span>Détail de l'enchère</span>
    </v-card-title>

    <v-card-text class='card-info'>
          <div><div class="info-title inline-div">Demande</div><div class="content inline-div">{{viewedBill.category.name}}</div></div>
          <div><div class="info-title inline-div">Fournisseur Actuel</div><div class="content inline-div">{{viewedBill.current_provider}}</div></div>
          <div><div class="info-title inline-div">Prix</div><div class="content inline-div">{{viewedBill.price}} €/ mois</div></div>
          <div><div class="info-title inline-div">Consommation</div><div class="content inline-div">{{viewedBill.consumption}} KW/h</div></div>
          <div><div class="info-title inline-div">Ville</div><div class="content inline-div">{{viewedBill.city}}</div></div>
      <v-spacer></v-spacer>
      <v-divider></v-divider>
      <h5 class='text-center bold'> Enchères en cours</h5>
      <v-data-table :headers="bidHeaders" :items="viewedBill.bids" item-key="title" :rows-per-page-items="[5,10]" rows-per-page-text="Résultats par page" >
        <template v-slot:items="props">
          <tr >
            <td class="text-xs-left" >{{ props.item.account.company }}</td>
            <td class="text-xs-right">{{ props.item.bid.price }} €/ mois</td>
          </tr>
        </template>
      </v-data-table>
    </v-card-text>

    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="success darken-1" flat @click="$emit('close')">Fermer</v-btn>
      <v-btn color="success darken-1" flat @click="dialog2 = true" v-if='canBid'>Enchérir</v-btn>
    </v-card-actions>
  </v-card>

  <!-- Second Dialog With Form -->
  <v-dialog v-model="dialog2" max-width="500px" v-if='canBid'>
      <v-card class='rounded'>
        <v-form ref="form" v-model="valid" lazy-validation>
          <v-card-title class="headline">
            <span >Enchérir</span>
          </v-card-title>
          <v-card-text>
            <v-container grid-list-md>
              <v-layout wrap>
                <v-flex xs12>
                  <v-text-field label="Prix" v-model='price' :rules='[required, number]'></v-text-field>
                </v-flex>
                <v-flex xs12>
                  <v-textarea label="Commentaire" v-model='content' ></v-textarea>
                </v-flex>
              </v-layout>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="success darken-1" flat @click="dialog2 = false">Fermer</v-btn>
            <v-btn color="success darken-1" flat @click="createBid()">Enregistrer</v-btn>
          </v-card-actions>
        </v-form>
      </v-card>
  </v-dialog>
</div>
</template>

<script>
  import {required, number} from '../../shared_components/validate'
  export default {
    name: 'BidDialog',
    props: ['viewedBill', 'canBid'],
    data: () => ({
      required: required, number: number,
      valid: false,
      price: null,
      content: null,
      bidHeaders: [
        { text: 'Fournisseur', align: 'left', value: 'bid_provider'},
        { text: 'Prix', value: 'bid_price', align: 'right'},
      ],
      dialog2: false,
    }),
    methods: {
      createBid() {
        if (this.$refs.form.validate()) {
          const formData = {
            bid: {
              bill_id: this.viewedBill.id,
              price: this.price,
              content: this.content,
              user_id: this.$store.getters.Provider.attributes.id
            }
          }
          this.$store.dispatch('CREATE_BID', formData)
        }
      }
    }
  }
</script>

