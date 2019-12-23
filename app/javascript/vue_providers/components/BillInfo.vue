<template>
  <div>
    <v-card class="rounded">
      <v-card-title class="headline sm">
        <span>Informations Supplémentaires</span>
      </v-card-title>
      <v-card-text class="card-info">
        <div>
          <div class="info-title inline-div">Type de bien</div>
          <div class="content inline-div">{{ viewedBill.type_home }}</div>
        </div>
        <div>
          <div class="info-title inline-div">Nombre d'occupants</div>
          <div class="content inline-div">
            {{ viewedBill.nb_people }}
          </div>
        </div>
        <div>
          <div class="info-title inline-div">Surface du bien</div>
          <div class="content inline-div">{{ viewedBill.surface }} m2</div>
        </div>
        <div>
          <div class="info-title inline-div">Moyen de chauffage</div>
          <div class="content inline-div">
            {{ viewedBill.heating }}
          </div>
        </div>
        <div>
          <div class="info-title inline-div">Eau chaude</div>
          <div class="content inline-div">
            {{ viewedBill.hot_water }}
          </div>
        </div>
        <div>
          <div class="info-title inline-div">Apareils Electroménager</div>
          <div class="content inline-div">
            <ul>
              <li v-if="viewedBill.dishwasher">Lave Vaiselle</li>
              <li v-if="viewedBill.fridge">Refrigirateur</li>
              <li v-if="viewedBill.freezer">Congélateur</li>
              <li v-if="viewedBill.oven">Four</li>
              <li v-if="viewedBill.washer">Machine à Laver</li>
              <li v-if="viewedBill.dryer">Seche-Linge</li>
            </ul>
          </div>
        </div>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="primary" flat @click="$emit('close')">Ok</v-btn>
      </v-card-actions>
    </v-card>
  </div>
</template>

<script>
export default {
  name: "BillInfo",
  props: {
    viewedBill: Object
  }
};
</script>
