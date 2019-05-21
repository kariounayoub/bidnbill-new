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
                    <div class="form-subtitle inline-div">Combien de personnes l'occupent ?</div>
                    <div class="form-content inline-div">
                        <v-select v-model="nb_people" :items="listPeople" outline :rules="[required]" ></v-select>
                    </div>
                  </div>
                  <div>
                    <div class="form-subtitle inline-div">Quelle est la surface (en m2) ?</div>
                    <div class="form-content inline-div">
                        <v-text-field v-model="surface" outline :rules="[required, number]" />
                    </div>
                  </div>
                  <div>
                    <div class="form-subtitle inline-div">Occupez-vous votre logement plutôt ?</div>
                    <div class="form-content inline-div">
                        <v-select v-model="occupation" outline :rules="[required]" :items="listOccupation"></v-select>
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
                        <v-select v-model="chauffage" :items="listChauffage" outline :rules="[required]" ></v-select>
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
          <v-btn color="success darken-1" flat @click="dialog2 = true">Valider</v-btn>
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
      occupation: 'En permanance',
      hot_water: "Ballon d'eau chaude",
      chauffage: "Electricité",
      listHome: ['Maison', 'Appartement'],
      listPeople: [1,2,3,4,5,'6+'],
      listOccupation: ['En permanance', 'Soir & Weekend', 'Weekend & Vacances', 'Vacances', 'Autre'],
      listHotWater: ['Chaudière individuelle', "Ballon d'eau chaude", "Autre"],
      listChauffage: ['Electricité', 'Gaz', 'Autre'],
    })
  }
</script>
