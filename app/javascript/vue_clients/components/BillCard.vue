<template>
  <div>
    <v-card class="user_card rounded">
      <v-layout column justify-content-between>
        <div class="user_card__top">
          <div class="user_card__image" v-bind:style="{backgroundImage: 'url(' + getImage + ')'}"></div>
        </div>
        <div class='user_card__middle'>
          <div class="card-category"><i class="fas fa-lightbulb"></i>  {{bill.attributes.category.name}}</div>
          <div class="card-info">
            <div><div class="info-title inline-div">Nom</div><div class="content inline-div">{{client.full_name}}</div></div>
            <div><div class="info-title inline-div">Fournisseur</div><div class="content inline-div">{{bill.attributes.current_provider}}</div></div>
            <div><div class="info-title inline-div">Consommation</div><div class="content inline-div">{{bill.attributes.consumption}} KW/h</div></div>
            <div><div class="info-title inline-div">Prix</div><div class="content inline-div">{{bill.attributes.price}} € / mois</div></div>
            <div><div class="info-title inline-div">Addresse</div><div class="content inline-div">{{bill.attributes.address}}</div></div>
          </div>
          <v-btn color="primary" class='rounded primary edit-position' @click='dialog = true' v-if='bill.attributes.is_open'><v-icon>edit</v-icon>Modifier</v-btn>
        </div>
        <div class="user_card__bottom hidden-xs-only">
          <Map :coordinates='coordinates' :accessToken='accessToken' />
        </div>
      </v-layout>
    </v-card>
    <!-- Dialog Edit Bill -->
      <v-dialog v-model="dialog" max-width="500px" v-if='bill.attributes.is_open'>
        <EditBill v-on:close='close'/>
      </v-dialog>

  </div>
</template>

<script>
  import getProviderImage from '../get_provider_image.js';
  import Map from '../../shared_components/Map'
  import EditBill from './EditBill'
  export default {
    name: 'BillCard',
    props: ['bill'],
    components: {
      Map,
      EditBill
    },
    data: () => ({
      dialog: false,
    }),
    watch: {
      dialog (val) {
        val || this.close()
      }
    },
    methods: {
      close () {
        this.dialog = false
      },
    },
    computed: {
      getImage() {
         if(this.bill !== null) return getProviderImage(this.bill.attributes.current_provider)
      },
      client () {
        return this.$store.getters.Client.attributes
      },
      accessToken() {
        return this.$store.getters.MapKey
      },
      coordinates() {
        if (this.bill.attributes.latitude !== undefined) {
          return [this.bill.attributes.longitude, this.bill.attributes.latitude]
        } else {
          return null
        }
      }
    },
  }
</script>

