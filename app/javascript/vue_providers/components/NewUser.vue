<template>
  <div>
    <!-- Main Dialog -->
    <v-form ref="form" v-model="valid" lazy-validation>
      <v-card class="rounded">
        <v-card-title class="headline sm">
          <span>Nouvelle Utilisateur</span>
        </v-card-title>

        <v-card-text>
          <div class="mx-3">
            <v-text-field v-model="last_name" :rules="[required]" label="Nom" />
            <v-text-field v-model="first_name" :rules="[required]" label="Prénom" />
            <v-text-field v-model="phone" :rules="[required, isPhone]" label="Numéro de Téléphone" />
            <v-text-field v-model="email" :rules="[required, isEmail]" label="Email" />
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" flat @click="$emit('close')">Fermer</v-btn>
          <v-btn color="primary" flat @click="handleValidate">Valider</v-btn>
        </v-card-actions>
      </v-card>
    </v-form>
  </div>
</template>

<script>
import { required, isPhone, isEmail } from "../../shared_components/validate";
export default {
  name: "NewUser",
  data: () => ({
    required: required,
    isPhone: isPhone,
    isEmail: isEmail,
    last_name: null,
    first_name: null,
    phone: null,
    email: null,
    valid: false
  }),

  methods: {
    handleValidate() {
      if (this.$refs.form.validate()) {
        const formData = {
          user: {
            first_name: this.first_name,
            last_name: this.last_name,
            phone_number: this.phone,
            email: this.email
          }
        };
        console.log(formData);
        this.$store.dispatch("NEW_USER", formData);
      }
      this.$emit("close");
    }
  }
};
</script>

