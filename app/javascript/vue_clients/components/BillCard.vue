<template>
  <div>
    <v-card class="bill__card rounded">
      <v-layout column justify-content-between>
        <div class="bill__card__top">
          <div class="bill__card__image" v-bind:style="{backgroundImage: 'url(' + getImage + ')'}"></div>
        </div>
        <div class='bill__card__middle'>
          <div class="card-category"><i class="fas fa-lightbulb"></i>  {{bill.attributes.category.name}}</div>
          <div class="card-info">
            <div><div class="info-title inline-div">Nom</div><div class="content inline-div">{{client.full_name}}</div></div>
            <div><div class="info-title inline-div">Fournisseur</div><div class="content inline-div">{{bill.attributes.current_provider}}</div></div>
            <div><div class="info-title inline-div">Consommation</div><div class="content inline-div">{{bill.attributes.consumption}} KW/h</div></div>
            <div><div class="info-title inline-div">Prix</div><div class="content inline-div">{{bill.attributes.price}} € / mois</div></div>
            <div><div class="info-title inline-div">Addresse</div><div class="content inline-div">{{bill.attributes.address}}</div></div>
          </div>
        </div>
        <div class="bill__card__bottom hidden-xs-only">
          <MglMap v-if='coordinates !== null' class="rounded" :accessToken="accessToken" :mapStyle="'mapbox://styles/mapbox/streets-v10'" :center="coordinates" :zoom='10'>
            <MglMarker  :coordinates="coordinates" color="green" />
          </MglMap>
        </div>
      </v-layout>
    </v-card>
  </div>
</template>

<script>
  import getProviderImage from '../get_provider_image.js';
  import Mapbox from "mapbox-gl";
  import { MglMap, MglMarker } from "vue-mapbox";

  export default {
    name: 'BillCard',
    props: ['bill'],
    components: {
      MglMap,
      MglMarker
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
    created() {
      // We need to set mapbox-gl library here in order to use it in template
      this.mapbox = Mapbox;
    }
  }
</script>

<style scoped lang='scss'>
  .bill__card {
    .bill__card__top {
      height: 100px;
      background: linear-gradient(234.15deg, var(--v-success-base) -28.36%, #FFFFFF 171.84%);
      width: 100%;
      display: flex;
      align-items: center;
      border-radius: 30px 4px 0px 0px;
      .bill__card__image {
        height: 70%;
        width: 100%;
        background-repeat: no-repeat;
        background-size: contain;
        background-position: center;
      }
    }
    .bill__card__middle {
      display: flex;
      flex-direction: column;
      text-align: center;
      justify-content: space-between;
      width: 100%;
      padding: 20px 0;
      .card-category {
        padding-bottom: 20px;
        font-size: 20px;
        color: var(--v-success-base);
        font-weight: 600;
      }
      .card-info {
        text-align: left;
        padding-left: 10px;
        font-size: 14px;
        font-weight: 700;


        .info-title {
          color: #aaa;
          width: 50%;
          padding-bottom: 10px;
        }
        .content {
          width: 50%;
        }

      }
    }
    .bill__card__bottom {
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
  .bill__card__bottom .mapboxgl-map {
    border-radius: 0 0px 30px 4px !important;
  }
</style>
