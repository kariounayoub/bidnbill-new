<template>
  <div>
    <v-card class="rounded">
      <v-card-title class="headline sm">
        <span
          >Modifier le Statut de
          {{ client.client.data.attributes.full_name }}</span
        >
      </v-card-title>
      <v-form ref="form" v-model="valid" lazy-validation>
        <v-card-text>
          <v-select
            class="m-5"
            v-model="client_status"
            :items="client_statusList"
            :rules="[required]"
            label="Statut"
          ></v-select>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" flat @click="$emit('close')">Fermer</v-btn>
          <v-btn color="primary" flat @click="handleValidate">Valider</v-btn>
        </v-card-actions>
      </v-form>
    </v-card>
  </div>
</template>

<script>
import { required } from "../../shared_components/validate";
export default {
  name: "EditClientStatusDialog",
  props: ["client"],
  data: () => ({
    valid: false,
    required: required,
    client_status: null,
    client_statusList: [
      "Nouveau",
      "A Contacter",
      "Contact en cours",
      "Contact Refusé",
      "Contact Accépté"
    ]
  }),
  watch: {
    client() {
      this.client_status = this.client.bid.data.attributes.client_status;
    }
  },
  methods: {
    handleValidate() {
      if (this.$refs.form.validate()) {
        const formData = {
          bid_id: this.client.bid.data.id,
          bid: {
            client_status: this.client_status
          }
        };
        this.$store.dispatch("UPDATE_BID", formData);
        this.$emit("close");
      }
    }
  },
  mounted() {
    this.client_status = this.client.bid.data.attributes.client_status;
  }
};
</script>
