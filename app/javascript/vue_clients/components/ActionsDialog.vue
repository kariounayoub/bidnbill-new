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
      <v-card class="rounded padded-card">
        <v-card-text class="text-center">
          <i class="fa fa-exclamation-circle icon-danger"></i>
          <h5 class="heading-danger">
            Attention, vous êtes sur le point de valider cette offre, seul ce
            fournisseur pourra désormais vous contacter pour envisager de
            conclure un nouveau contrat
          </h5>
          <h6 class="heading-danger">Etes-vous sur de vouloir continuer?</h6>
        </v-card-text>
        <v-spacer></v-spacer>
        <v-card-actions class="flex-center">
          <v-btn color="primary" flat @click="dialog2 = false">Annuler</v-btn>
          <v-btn class="rounded success large" flat @click="handleValidate"
            >Accépter</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  name: "ActionsDialog",
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
