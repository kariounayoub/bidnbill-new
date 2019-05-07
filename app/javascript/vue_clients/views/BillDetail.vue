<template>
  <div>
    <h3 class="dashboard__title">Abonnement {{currentProvider}}</h3>
    {{activeBill}}
  </div>
</template>

<script>
  import {mapState} from 'vuex'

  export default {
    name: 'BillDetail',
    props: ['id'],
    computed: {
      ...mapState(['bills']),
      activeBill() {
        return this.$store.getters.ActiveBill
      },
      currentProvider() {
        if(this.activeBill !== null) return this.activeBill.attributes.current_provider
      }
    },
    mounted() {
      if (this.bills.data.data === null) {
        this.$store.dispatch('GET_BILL', this.id)
      } else {
        this.$store.commit('SET_ACTIVE_BILL', this.id)
      }
    }
  }
</script>
