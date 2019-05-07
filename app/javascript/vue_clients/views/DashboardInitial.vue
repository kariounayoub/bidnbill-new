<template>
  <div class='top-margin'>
    Hello {{client.data.attributes.full_name}}
    <p>
      {{bills}}
    </p>
  </div>
</template>

<script>

  export default {
    name: 'DashboardInitial',
    computed: {
      client() {
        return this.$store.getters.Client
      },
      bills() {
        return this.$store.getters.Bills
      }
    },
    mounted() {
      this.$store.dispatch('GET_BILLS');
    }
  }
</script>

<style>
  .top-margin {
    margin-top: 64px;
  }
</style>
