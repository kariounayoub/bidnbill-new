<template>
  <div>
    <h3 class="dashboard__title">Sélectionner votre type de contrat</h3>
    <v-container>
      <v-stepper v-model="e1" alt-labels>
        <!-- HEADER -->
        <v-stepper-header class="display-none">
          <v-stepper-step step="1"></v-stepper-step>
          <v-stepper-step step="2"></v-stepper-step>
        </v-stepper-header>

        <!-- CONTENT -->
        <v-stepper-items>
          <!-- STEP 1 -->
          <v-stepper-content step="1">
            <v-form ref="form1" v-model="valid" lazy-validation>
              <BillFormStep1 ref="step1" />
              <v-btn
                id="suivant1"
                class="right rounded"
                :disabled="!valid"
                @click="validate(1,2)"
              >Suivant</v-btn>
            </v-form>
          </v-stepper-content>

          <!-- STEP 2 -->
          <v-stepper-content step="2">
            <v-form ref="form2" v-model="valid" lazy-validation>
              <BillFormStep2 ref="step2" />
              <v-btn class="left rounded" :disabled="!valid" @click="back()">Précédent</v-btn>
              <v-btn
                id="suivant2"
                class="right rounded"
                :disabled="!valid"
                @click="validate(2,2)"
              >Créer une enchère</v-btn>
            </v-form>
          </v-stepper-content>
        </v-stepper-items>
      </v-stepper>
    </v-container>
  </div>
</template>

<script>
import BillFormStep1 from "../components/BillFormStep1";
import BillFormStep2 from "../components/BillFormStep2";

export default {
  name: "BillForm",
  components: {
    BillFormStep1,
    BillFormStep2
  },
  data() {
    return {
      e1: 0,
      valid: true
    };
  },
  computed: {
    clientId() {
      return this.$store.getters.Client.attributes.id;
    }
  },
  methods: {
    validate(step, page) {
      let form = null; // This if loop is for partial validation of each form individually
      if (step === 1) {
        form = this.$refs.form1;
      } else if (step === 2) {
        form = this.$refs.form2;
      }
      if (form.validate()) {
        this.e1 = page;
        if (step === 2) {
          // This is where all the form data is cleaned and sent to post requests
          const formValues = {
            bill: {
              user_id: this.clientId,
              category_id: this.$refs.step1.billType,
              payment_frequency: this.$refs.step2.payment_frequency,
              price: this.$refs.step2.price,
              current_provider: this.$refs.step2.current_provider,
              consumption: this.$refs.step2.consumption,
              address: this.$refs.step2.address,
              city: this.$refs.step2.city,
              calculated_consumption: !this.$refs.step2.consumption_q,
              pdl: this.$refs.step2.pdl,
              energie_verte: this.$refs.step2.energie_verte,
              ...this.$refs.step2.consumptionData
            }
          };
          this.$store.dispatch("CREATE_BILL", formValues);
        }
      }
    },
    back() {
      this.e1--;
    }
  }
};
</script>


<style scoped>
/*CUSTOM STYLING OF STEPPER TITLE*/
.v-stepper {
  background: white !important;
  border-radius: 30px 4px 30px 4px;
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
  color: rgba(0, 0, 0, 0.8);
  h4 {
    font-weight: 700;
  }
}
</style>
