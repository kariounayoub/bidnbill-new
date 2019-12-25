<template>
  <div>
    <v-card class="rounded">
      <v-card-title class="headline">
        <span>Détails de l'offre</span>
      </v-card-title>
      <v-card-text>
        <p>
          <strong>Prix :</strong>
          {{ price }} €
        </p>
        <h4 class="text-center">Proposition</h4>
        <p>{{ text }}</p>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="primary " flat @click="$emit('close')">Fermer</v-btn>
        <v-btn color="success darken-2" flat @click="dialog2 = true">Accépter</v-btn>
      </v-card-actions>
    </v-card>

    <!-- Second Dialog for Validation -->
    <v-dialog v-model="dialog2" max-width="500px">
      <AlertDialog
        v-on:validate="handleValidate"
        v-on:close="dialog2 = false"
        v-bind:text="
          'Attention, vous êtes sur le point de valider cette offre, seul ce fournisseur pourra désormais vous contacter pour envisager de conclure un nouveau contrat'
        "
      >
        <v-form ref="form" v-model="valid" lazy-validation>
          <v-select
            class="m-5"
            v-model="contact"
            :items="contactList"
            :rules="[required]"
            label="Comment souhaitez vous être contacté"
          ></v-select>
          <v-select
            class="m-5"
            v-model="contact_preferences"
            :items="contactPreferencesList"
            :rules="[required]"
            label="Quels sont les plages horraires qui vous conviennent le mieux"
          ></v-select>
        </v-form>
      </AlertDialog>
    </v-dialog>
  </div>
</template>

<script>
import AlertDialog from "../../shared_components/AlertDialog";
import { required } from "../../shared_components/validate";

export default {
  name: "ActionsDialog",
  components: {
    AlertDialog
  },
  props: {
    price: Number,
    text: String
  },
  data: () => ({
    required: required,
    dialog: false,
    dialog2: false,
    contact: "email",
    contactList: ["téléphone", "email"],
    contact_preferences: "8h - 12h",
    contactPreferencesList: ["8h - 12h", "12h - 16h", "16h - 20h"],
    valid: false
  }),
  methods: {
    handleValidate() {
      if (this.$refs.form.validate()) {
        const formData = {
          bid: {
            methode_contact: this.contact,
            contact_preferences: this.contact_preferences
          }
        };
        this.$emit("validate", formData);
        this.dialog = false;
        this.dialog2 = false;
        this.$emit("close");
      }
    }
  }
};
</script>

<style scoped>
h4 {
  font-weight: bold;
  margin-bottom: 5px;
}
p {
  white-space: pre-line;
}
i {
  color: var(--v-error-base);
  font-size: 50px;
  margin-bottom: 10px;
}
</style>
