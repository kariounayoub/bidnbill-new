<template>
  <div>
    <v-card class="user_card rounded">
      <v-layout column justify-content-between>
        <div class="user_card__top flex-center">
          <h4>Majid Jaidi</h4>
        </div>
        <div class="user_card__middle">
          <div class="card-category">
            <i class="fas fa-lightbulb"></i>
            {{ client.bill.data.attributes.category.name }}
          </div>
          <div class="card-info">
            <div>
              <div class="info-title inline-div">Nom</div>
              <div class="content inline-div">
                {{ client.client.data.attributes.full_name }}
              </div>
            </div>
            <div>
              <div class="info-title inline-div">E-mail</div>
              <div class="content inline-div">
                {{ client.client.data.attributes.email }}
              </div>
            </div>
            <div>
              <div class="info-title inline-div">Téléphone</div>
              <div class="content inline-div">
                {{ client.client.data.attributes.phone_number }}
              </div>
            </div>
            <div>
              <div class="info-title inline-div">
                Moyen de contact souhaité
              </div>
              <div class="content inline-div">
                {{ client.bid.data.attributes.methode_contact }}
              </div>
            </div>
            <div>
              <div class="info-title inline-div">Prix Offre</div>
              <div class="content inline-div">
                {{ client.bid.data.attributes.price }} € / mois
              </div>
            </div>
            <div>
              <div class="info-title inline-div">Consommation</div>
              <div class="content inline-div">
                {{ client.bill.data.attributes.consumption }} kWh
              </div>
            </div>
            <div>
              <div class="info-title inline-div">Addresse</div>
              <div class="content inline-div">
                {{ client.bill.data.attributes.address }}
              </div>
            </div>
            <div>
              <div class="info-title inline-div">Ville</div>
              <div class="content inline-div">
                {{ client.bill.data.attributes.city }}
              </div>
            </div>
            <div>
              <div class="info-title inline-div">Numéro PDL</div>
              <div class="content inline-div">
                {{ client.bill.data.attributes.pdl }}
              </div>
            </div>
            <div
              class="green-text text-center my-3"
              v-if="client.bill.data.attributes.energie_verte"
            >
              Energie verte seulement
            </div>
            <div class="flex-center">
              <v-btn color="primary" @click="dialog = true">
                Informations Supplémentaires
              </v-btn>
            </div>
          </div>
        </div>
        <div class="user_card__bottom hidden-xs-only">
          <Map :coordinates="coordinates" :accessToken="accessToken" />
        </div>
      </v-layout>
    </v-card>

    <!--  Dialog With Bill Info -->
    <v-dialog v-model="dialog" max-width="600px">
      <BillInfo
        v-bind:viewedBill="client.bill.data.attributes"
        v-on:close="dialog = false"
      />
    </v-dialog>
  </div>
</template>

<script>
import Map from "../../shared_components/Map";
import BillInfo from "./BillInfo";
export default {
  name: "ClientCard",
  props: ["client"],
  data: () => ({
    dialog: false
  }),
  components: {
    Map,
    BillInfo
  },
  computed: {
    accessToken() {
      return this.$store.getters.MapKey;
    },
    coordinates() {
      if (this.client.bill.data.attributes.latitude !== undefined) {
        return [
          this.client.bill.data.attributes.longitude,
          this.client.bill.data.attributes.latitude
        ];
      } else {
        return null;
      }
    }
  }
};
</script>

<style scoped lang="scss">
.user_card {
  .user_card__top {
    height: 40px;
    h4 {
      color: white;
      font-size: 16px;
      font-weight: bold;
    }
  }
  .card-info {
    padding-left: 10px;
    font-size: 12px;
    .info-title {
      width: 39%;
    }
    .content {
      width: 60%;
    }
  }
}
</style>
