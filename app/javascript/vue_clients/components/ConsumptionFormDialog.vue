<template>
  <div>
    <v-card class='rounded'>
        <v-card-title class="headline">
          <span >Estimez votre consommation</span>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex xs12 class='form-fields compact-form'>
                <div class='form-section'>
                  <h3 class='form-header'>Votre Logement</h3>
                  <div>
                    <div class="form-subtitle inline-div">Votre logement est ?</div>
                    <div class="form-content inline-div">
                        <v-select v-model="type_home" :items="listHome" outline :rules="[required]" ></v-select>
                    </div>
                  </div>
                  <div>
                    <div class="form-subtitle inline-div">Quelle est la surface (en m2) ?</div>
                    <div class="form-content inline-div">
                        <v-text-field v-model="surface" outline :rules="[required, number]" />
                    </div>
                  </div>
                  <div>
                    <div class="form-subtitle inline-div">Combien de personnes l'occupent ?</div>
                    <div class="form-content inline-div">
                        <v-select v-model="nb_people" :items="listPeople" outline :rules="[required]" ></v-select>
                    </div>
                  </div>
                </div>
                <div class='form-section'>
                  <h3 class='form-header'>Chauffage</h3>
                  <div>
                    <div class="form-subtitle inline-div">Comment est chauffé votre eau ?</div>
                    <div class="form-content inline-div">
                        <v-select v-model="hot_water" :items="listHotWater" outline :rules="[required]" ></v-select>
                    </div>
                  </div>
                  <div>
                    <div class="form-subtitle inline-div">Comment est chauffé votre logement ?</div>
                    <div class="form-content inline-div">
                        <v-select v-model="heating" :items="listChauffage" outline :rules="[required]" ></v-select>
                    </div>
                  </div>
                </div>
                <div class='form-section'>
                  <h3 class='form-header'>Appareils Electroménager</h3>
                  <div class='flex-center'>
                    <div class="form-content inline-div padded-left">
                        <v-switch color='success' v-model="fridge" label='Réfrigirateur' outline ></v-switch>
                    </div>
                    <div class="form-content inline-div">
                        <v-switch color='success' v-model="freezer" label='Congélateur (séparé)' outline ></v-switch>
                    </div>
                  </div>

                  <div class='flex-center'>
                    <div class="form-content inline-div padded-left">
                        <v-switch color='success' v-model="oven" label='Four' outline ></v-switch>
                    </div>
                    <div class="form-content inline-div">
                        <v-switch color='success' v-model="dishwasher" label='Lave-vaisselle' outline ></v-switch>
                    </div>
                  </div>

                  <div class='flex-center'>
                    <div class="form-content inline-div padded-left">
                        <v-switch color='success' v-model="washer" label='Lave-linge' outline ></v-switch>
                    </div>
                    <div class="form-content inline-div">
                        <v-switch color='success' v-model="dryer" label='Seche-linge' outline ></v-switch>
                    </div>
                  </div>

                </div>

              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="success darken-1" flat @click="$emit('close')">Fermer</v-btn>
          <v-btn color="success darken-1" flat @click="calculateConsumption()">Valider</v-btn>
        </v-card-actions>
    </v-card>

  </div>
</template>

<script>
  import {required, number} from '../../shared_components/validate'

  export default {
    name: 'ConsumptionFormDialog',
    data: () => ({
      required: required, number: number,
      type_home: 'Maison',
      nb_people: 2,
      surface: 100,
      hot_water: "Ballon d'eau chaude",
      heating: "Electricité",
      fridge: true,
      freezer: false,
      oven: true,
      dishwasher: false,
      washer: true,
      dryer: false,
      listHome: ['Maison', 'Appartement'],
      listPeople: [1,2,3,4,5,'6+'],
      listHotWater: ['Chaudière individuelle', "Ballon d'eau chaude", "Autre"],
      listChauffage: ['Electricité', 'Gaz', 'Autre'],
    }),
    methods: {
      // Consumption Calculation
      calculateConsumption() {
        // Estimate data from https://www.fournisseur-energie.com/edf-fournisseur-historique/simulation/
        const estimateData = {
          fridge: 250,
          freezer: 250,
          dishwasher: 100,
          cooking_per_person: 270,
          washer: 180,
          dryer: 300,
          vacum: 150,
          microwave: 40,
          oven_per_person: 360,
          heating_per_meter: 100,
          tv: 200,
          computer_per_person: 30,
          lighting_per_person: 250,
          hot_water_per_person: 800
        }

        const type_heating = () => {return this.heating == 'Electricité' ? 1 : 0}
        const type_hot_water = () => {return this.hot_water == 'Chaudière individuelle' ? 1 : 0}
        const people = parseInt(this.nb_people)
        const fridge_consumption = () => {return this.fridge ? estimateData.fridge : 0}
        const freezer_consumption = () => {return this.freezer ? estimateData.freezer : 0}
        const dishwasher_consumption = () => {return this.dishwasher ? estimateData.dishwasher : 0}
        const washer_consumption = () => {return this.washer ? estimateData.washer : 0}
        const dryer_consumption = () => {return this.dryer ? estimateData.dryer : 0}
        const oven_consumption = () => {return this.oven ? estimateData.oven_per_person * people : 0}
        const calculated_form = () => { return (
          type_heating() * this.surface * estimateData.heating_per_meter +
          type_hot_water() * people * estimateData.hot_water_per_person +
          fridge_consumption() + freezer_consumption() + dishwasher_consumption() +
          washer_consumption() + dryer_consumption() + oven_consumption() +
          estimateData.cooking_per_person * people  +
          estimateData.computer_per_person * people + estimateData.lighting_per_person * people +
          estimateData.vacum + estimateData.microwave + estimateData.tv
          )}

        const consumptionData = {
          type_home: this.type_home,
          nb_people: parseInt(this.nb_people),
          surface: this.surface,
          hot_water: this.hot_water,
          heating: this.heating,
          fridge: this.fridge,
          freezer: this.freezer,
          oven: this.oven,
          dishwasher: this.dishwasher,
          washer: this.washer,
          dryer: this.dryer,
        }
        this.$emit('consumptionData', consumptionData)
        this.$emit('calculation', calculated_form())
        this.$emit('close')
      }
    }
  }

</script>

<style scoped>
  .padded-left {
    padding-left: 5%;
  }
</style>
