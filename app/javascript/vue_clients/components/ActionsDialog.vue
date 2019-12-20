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
        <v-btn color="success darken-2" flat @click="dialog2 = true"
          >Accépter</v-btn
        >
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
      />
    </v-dialog>
  </div>
</template>

<script>
import AlertDialog from "../../shared_components/AlertDialog";
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
    dialog: false,
    dialog2: false
  }),
  methods: {
    handleValidate() {
      console.log("validate");
      this.$emit("validate");
      this.dialog = false;
      this.dialog2 = false;
      this.$emit("close");
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
