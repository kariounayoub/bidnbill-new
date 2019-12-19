<template>
  <div>
    <div class="align-content-right">
      <v-btn color="primary" @click="dialog = true">Ajouter un Utilisateur</v-btn>
    </div>
    <v-card class="rounded">
      <v-card-title class="headline sm">
        <span>Nos utilisateurs</span>
      </v-card-title>
      <v-layout row wrap class="inside-card">
        <v-flex xs12>
          <v-data-table
            :headers="headers"
            :items="users"
            item-key="title"
            :rows-per-page-items="[10,25,50,100]"
            rows-per-page-text="Résultats par page"
            must-sort
          >
            <template v-slot:items="props">
              <tr>
                <td class="text-xs-left">{{props.item.data.attributes.first_name}}</td>
                <td class="text-xs-right">{{props.item.data.attributes.last_name}}</td>
                <td class="text-xs-right">{{props.item.data.attributes.email}}</td>
                <td class="text-xs-right pointer">
                  <v-icon>visibility</v-icon>
                </td>
              </tr>
            </template>
          </v-data-table>
        </v-flex>
      </v-layout>
    </v-card>
    <!-- Dialog -->
    <v-dialog v-model="dialog" max-width="700px">
      <NewUser v-on:close="dialog = false" />
    </v-dialog>
  </div>
</template>



<script>
import NewUser from "./NewUser";
export default {
  name: "AccountInfo",
  components: {
    NewUser
  },
  data: () => ({
    dialog: false,
    headers: [
      {
        text: "Prénom",
        align: "left",
        value: "data.attributes.first_name"
      },
      {
        text: "Nom",
        value: "data.attributes.last_name",
        align: "right"
      },
      { text: "Email", value: "data.attributes.email", align: "right" },
      { text: "Actions", value: "actions", align: "right" }
    ]
  }),
  computed: {
    users() {
      return this.$store.getters.Account.attributes.account_users;
    }
  }
};
</script>

<style scoped>
.align-content-right {
  display: flex;
  justify-content: flex-end;
  margin: 0 20px;
}
</style>