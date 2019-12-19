<template>
  <div>
    <h3 class="dashboard__title">Compte Entreprise</h3>
    <v-container>
      <AccountInfo />
      <AccountUsers />
    </v-container>
  </div>
</template>

<script>
import AccountInfo from "../components/AccountInfo";
import AccountUsers from "../components/AccountUsers";

export default {
  name: "EditAccount",
  components: {
    AccountInfo,
    AccountUsers
  },
  computed: {
    entreprise() {
      return this.$store.getters.Account.attributes;
    }
  },
  mounted() {
    this.$store.commit("HIDE_SIDEBAR");
  },
  beforeDestroy() {
    this.$store.commit("TOOGLE_SIDEBAR_STATE");
  }
};
</script>