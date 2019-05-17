<template>
  <div>
    <EditUserForm v-bind:user='user'/>
  </div>
</template>

<script>
  import EditUserForm from '../../shared_components/EditUserForm'
  export default {
    name: 'EditUser',
    components: {
      EditUserForm
    },
    computed: {
      user() {
        return this.$store.getters.Provider
      }
    }
  }
</script>
