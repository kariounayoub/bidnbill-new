<template>
  <v-card class="rounded">
    <div class="AccountInfo">
      <img :src="info.picture" :alt="info.company" class="provider-img" />
      <div class="info-container">
        <div class="info-wrapper">
          <span class="info-title">Companie</span
          ><span class="info-content">{{ info.company }}</span>
        </div>
        <div class="info-wrapper">
          <span class="info-title">Déscription</span
          ><span class="info-content">{{ info.description }}</span>
        </div>
        <div class="info-wrapper">
          <span class="info-title">Adresse</span
          ><span class="info-content">{{ info.address }}</span>
        </div>
        <div class="info-wrapper">
          <span class="info-title">Numéro de Téléphone</span
          ><span class="info-content">{{ info.phone_number }}</span>
        </div>
        <div class="info-wrapper">
          <span class="info-title">Ville</span
          ><span class="info-content">{{ info.city }}</span>
        </div>
        <div class="info-wrapper">
          <span class="info-title">Nombre d'utilisateurs autorisés</span
          ><span class="info-content">{{ info.number_users_allowed }}</span>
        </div>
      </div>
      <v-btn color="primary" flat @click="dialog = true">
        Modifier <v-icon class="ml-2" color="primary">edit</v-icon>
      </v-btn>
    </div>
    <!-- Dialog -->
    <v-dialog v-model="dialog" max-width="700px">
      <UpdateAccount v-on:close="dialog = false" />
    </v-dialog>
  </v-card>
</template>

<script>
import UpdateAccount from "./UpdateAccount";
export default {
  name: "AccountInfo",
  components: {
    UpdateAccount
  },
  data: () => ({
    dialog: false
  }),
  computed: {
    info() {
      return this.$store.getters.Account.attributes;
    }
  }
};
</script>

<style scoped lang="scss">
.AccountInfo {
  margin: 0 0 20px 0;
  padding: 20px 20px 40px 20px;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  align-items: center;
  position: relative;
  .provider-img {
    height: 150px;
    width: 150px;
    object-fit: contain;
    margin: 20px 0;
  }
  .info-container {
    width: 80%;
    .info-wrapper {
      display: flex;
      justify-content: space-around;
      margin: 10px 0;
    }
    .info-title {
      width: 30%;
      font-weight: bold;
    }
    .info-content {
      width: 70%;
    }
  }
  button {
    position: absolute;
    bottom: 20px;
    right: 20px;
  }
}
</style>
