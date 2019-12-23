<template>
  <div>
    <v-card class="rounded padded-card">
      <v-card-text class="text-center">
        <i class="fa fa-exclamation-circle icon-danger"></i>
        <h5 class="heading-danger">
          {{ text }}
        </h5>
        <h6 class="heading-danger">Etes-vous sur de vouloir continuer?</h6>
        <slot></slot>
      </v-card-text>
      <v-spacer></v-spacer>
      <v-card-actions class="flex-center">
        <v-btn color="primary" flat @click="$emit('close')">Annuler</v-btn>
        <v-btn color="error" @click="$emit('validate')">Valider</v-btn>
      </v-card-actions>
    </v-card>
  </div>
</template>

<script>
export default {
  name: "AlertDialog",
  props: {
    text: String
  }
};
</script>

<style scoped>
i {
  color: var(--v-error-base);
  font-size: 50px;
  margin-bottom: 10px;
}
</style>
