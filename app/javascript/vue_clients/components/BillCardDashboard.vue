<template>
  <div>
    <v-card class="dashboard__card rounded">
      <v-layout justify-content-between>
        <div class="dashboard__card__right">
          <div class="card-category">
            <i class="fas fa-lightbulb"></i>
            {{bill.attributes.category.name}}
          </div>
          <div class="card-info">
            <h4>{{bill.attributes.current_provider}}</h4>
            <p>{{bill.attributes.standardized_price}} € / mois</p>
          </div>
          <router-link :to="'/bills/' + bill.attributes.id">
            <v-btn class="rounded">Mes offres</v-btn>
          </router-link>
        </div>
        <div class="dashboard__card__left">
          <div
            class="dashboard_card_image"
            v-bind:style="{backgroundImage: 'url(' + getImage + ')'}"
          ></div>
        </div>
      </v-layout>
    </v-card>
  </div>
</template>

<script>
import getProviderImage from "../get_provider_image.js";

export default {
  name: "Bill",
  props: ["bill"],
  computed: {
    getImage() {
      return getProviderImage(this.bill.attributes.current_provider);
    }
  }
};
</script>


