<template>
  <div>
    <v-card class="client_card rounded">
      <v-layout column justify-content-between>
        <div class="client_card__top flex-center">
          <h4>Majid Jaidi</h4>
        </div>
        <div class='client_card__middle'>
          <div class="card-category"><i class="fas fa-lightbulb"></i> {{client.bill.data.attributes.category.name}}</div>
          <div class="card-info">
            <div><div class="info-title inline-div">Nom</div><div class="content inline-div">{{client.client.data.attributes.full_name}}</div></div>
            <div><div class="info-title inline-div">E-mail</div><div class="content inline-div">{{client.client.data.attributes.email}}</div></div>
            <div><div class="info-title inline-div">Téléphone</div><div class="content inline-div">{{client.client.data.attributes.phone_number}}</div></div>
            <div><div class="info-title inline-div">Prix Offre</div><div class="content inline-div">{{client.bid.data.attributes.price}} € / mois</div></div>
            <div><div class="info-title inline-div">Consommation</div><div class="content inline-div">{{client.bill.data.attributes.consumption}} KW/h</div></div>
            <div><div class="info-title inline-div">Addresse</div><div class="content inline-div">{{client.bill.data.attributes.address}}</div></div>
            <div><div class="info-title inline-div">Ville</div><div class="content inline-div">{{client.bill.data.attributes.city}}</div></div>
          </div>
        </div>
        <div class="client_card__bottom hidden-xs-only">
          <MglMap v-if='coordinates !== null' class="rounded" :accessToken="accessToken" :mapStyle="'mapbox://styles/mapbox/streets-v10'" :center="coordinates" :zoom='10'>
            <MglMarker  :coordinates="coordinates" color="green" />
          </MglMap>
        </div>
      </v-layout>
    </v-card>
  </div>
</template>

<script>
  import Mapbox from "mapbox-gl";
  import { MglMap, MglMarker } from "vue-mapbox";

  export default {
    name: 'ClientCard',
    props: ['client'],
    components: {
      MglMap,
      MglMarker
    },
    computed: {
      accessToken() {
        return this.$store.getters.MapKey
      },
      coordinates() {
        if (this.client.bill.data.attributes.latitude !== undefined) {
          return [this.client.bill.data.attributes.longitude, this.client.bill.data.attributes.latitude]
        } else {
          return null
        }
      }
    },
    created() {
      // We need to set mapbox-gl library here in order to use it in template
      this.mapbox = Mapbox;
    }
  }
</script>

<style scoped lang='scss'>
  .client_card {
    .client_card__top {
      height: 40px;
      background: linear-gradient(234.15deg, var(--v-success-base) -28.36%, #FFFFFF 171.84%);
      width: 100%;
      border-radius: 30px 4px 0px 0px;
      h4 {
        color: white;
        font-size: 16px;
        font-weight: bold
      }
    }
    .client_card__middle {
      display: flex;
      flex-direction: column;
      text-align: center;
      justify-content: space-between;
      width: 100%;
      padding: 20px 0;
      .card-category {
        padding-bottom: 20px;
        font-size: 16px;
        color: var(--v-success-base);
        font-weight: 600;
      }
      .card-info {
        text-align: left;
        padding-left: 10px;
        font-size: 12px;
        font-weight: 700;


        .info-title {
          color: #aaa;
          width: 40%;
          padding-bottom: 10px;
        }
        .content {
          width: 60%;
        }

      }
    }
    .client_card__bottom {
      height: 200px;
      background: #eee;
      border-radius: 0 0px 30px 4px;
      display: flex;
      justify-content: center;
      align-items: center;
    }
  }
</style>

<style>
  .client_card__bottom .mapboxgl-map {
    border-radius: 0 0px 30px 4px !important;
  }
</style>
