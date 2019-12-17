<template>
  <div>
    <h3 class="dashboard__title">Mon Compte</h3>
    <v-container>
      <v-layout row wrap>
        <v-flex xs12 sm8 offset-sm-2 class="form-fields compact-form">
          <v-form ref="form" v-model="valid" lazy-validation>
            <v-card class="rounded">
              <div>
                <div>
                  <div class="form-subtitle inline-div">Vous êtes un particulier?</div>
                  <div class="form-content inline-div">
                    <v-switch
                      :label="booleanToString(particulier_q)"
                      v-model="particulier_q"
                      color="primary"
                    ></v-switch>
                  </div>
                </div>

                <div v-if="particulier_q">
                  <div class="form-subtitle inline-div">Nom</div>
                  <div class="form-content inline-div">
                    <v-text-field v-model="last_name" outline :rules="[required]" />
                  </div>
                </div>

                <div v-if="particulier_q">
                  <div class="form-subtitle inline-div">Prénom</div>
                  <div class="form-content inline-div">
                    <v-text-field v-model="first_name" outline :rules="[required]" />
                  </div>
                </div>

                <div v-if="!particulier_q">
                  <div class="form-subtitle inline-div">Raison sociale</div>
                  <div class="form-content inline-div">
                    <v-text-field v-model="company" outline :rules="[required]" />
                  </div>
                </div>

                <div>
                  <div class="form-subtitle inline-div">Numéro de Téléphone</div>
                  <div class="form-content inline-div">
                    <v-text-field v-model="phone" outline :rules="[required]" />
                  </div>
                </div>

                <div>
                  <div class="form-subtitle inline-div">Email</div>
                  <div class="form-content inline-div">
                    <v-text-field v-model="email" outline disabled :rules="[required]" />
                  </div>
                </div>
              </div>

              <div class="flex-center with-padding">
                <v-btn color="rounded" @click="editUser()">Enregistrer</v-btn>
              </div>
            </v-card>
          </v-form>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { required } from "./validate";
export default {
  name: "EditUserForm",
  props: ["user"],
  data: () => ({
    required: required,
    last_name: null,
    first_name: null,
    phone: null,
    email: null,
    company: null,
    particulier_q: true,
    valid: false
  }),
  methods: {
    booleanToString(param) {
      if (param) return "Oui";
      if (!param) return "Non";
    },
    editUser() {
      if (this.$refs.form.validate()) {
        const formData = {
          user: {
            first_name: this.first_name,
            last_name: this.last_name,
            company: this.company,
            phone_number: this.phone,
            email: this.email
          }
        };
        this.$store.dispatch("UPDATE_USER", formData);
      }
    }
  },
  mounted() {
    this.last_name = this.user.attributes.last_name;
    this.first_name = this.user.attributes.first_name;
    this.phone = this.user.attributes.phone_number;
    this.email = this.user.attributes.email;
    this.company = this.user.attributes.company;
  }
};
</script>

<style scoped lang='scss'>
.with-padding {
  padding: 30px;
}
</style>
