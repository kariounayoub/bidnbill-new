<template>
  <div>
    <h3 class="dashboard__title">Créer un Abonnement</h3>
    <v-container>
      <v-stepper v-model="e1" alt-labels>
        <!-- HEADER -->
          <v-stepper-header class='display-none'>
              <v-stepper-step step="1"></v-stepper-step>
              <v-stepper-step step="2"></v-stepper-step>
              <v-stepper-step step="3"></v-stepper-step>
          </v-stepper-header>

      <!-- CONTENT -->
        <v-stepper-items>
          <!-- STEP 1 -->
            <v-stepper-content step="1">
              <v-form ref="form1" v-model="valid" lazy-validation>
                <BillFormStep1 />
                <v-btn id="suivant1" color="success" class="right" :disabled="!valid" @click="validate(1,2)">Suivant</v-btn>
              </v-form>
            </v-stepper-content>

          <!-- STEP 2 -->
            <v-stepper-content step="2">
              <v-form ref="form2" v-model="valid" lazy-validation>
                <BillFormStep2 />
                <v-btn color="success" class="left" :disabled="!valid"  @click="back()">Précédent</v-btn>
                <v-btn id="suivant2" color="success" class="right" :disabled="!valid" @click="validate(2,3)">Suivant</v-btn>
              </v-form>
            </v-stepper-content>

          <!-- STEP 3 -->
            <v-stepper-content step="3">
              <v-form ref="form3" v-model="valid" lazy-validation>
                <br><br><br>
                Step 3 Content
                <br><br><br>
                <v-btn color="success" class="left"  :disabled="!valid" @click="back()">Précédent</v-btn>
                <v-btn id="suivant3" color="success" class="right" :disabled="!valid" @click="validate(3,1)">Valider</v-btn>
              </v-form>
            </v-stepper-content>

        </v-stepper-items>
      </v-stepper>
    </v-container>
  </div>
</template>

<script>
  import BillFormStep1 from '../components/BillFormStep1'
  import BillFormStep2 from '../components/BillFormStep2'

  export default {
    name: 'BillForm',
    components: {
      BillFormStep1,
      BillFormStep2
    },
    data () {
      return {
        e1: 0,
        valid: true,
      }
    },
    methods: {
      validate (step,page) {
        let form = null
        if (step === 1) {
          form = this.$refs.form1
        } else if (step === 2) {
          form = this.$refs.form2
        } else if (step === 3) {
          form = this.$refs.form3
        }
        if (form.validate()) {
          this.e1 = page
        }
      },
      back () {
        this.e1--
      }

    }
  }
</script>


<style scoped>
/*CUSTOM STYLING OF STEPPER TITLE*/
  .v-stepper {
    background: white !important;
  }
  .v-stepper__header {
    box-shadow: none;
  }


/*END OF STYLING OF STEPPER TITLE*/

</style>

<style lang='scss'>
    .v-stepper__label {
    font-size: 13px;
  }

  .form-title {
    text-align: center;
    color: rgba(0,0,0,0.8);
    h4 {
      font-weight: 700,
    }
  }
</style>
