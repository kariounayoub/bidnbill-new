<template>
  <div>
    <EditUserForm v-bind:user="user" />
  </div>
</template>

<script>
import EditUserForm from "../components/EditUserForm";
export default {
  name: "EditUser",
  components: {
    EditUserForm
  },
  computed: {
    user() {
      return this.$store.getters.Client;
    }
  }
};
</script>
