<template>
  <div>
    <h3 class="dashboard__title">Abonnement {{activeBill.bill.data.attributes.current_provider}}</h3>
    <v-container>
      <v-layout row wrap>
        <v-flex xs12 sm4>
          <BillCard v-bind:bill='activeBill' />
        </v-flex>
        <v-flex xs12 sm8>
          <BidList v-bind:bids='activeBill.bill.data.attributes.bids'/>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
  import {mapState} from 'vuex'
  import BillCard from '../components/BillCard'
  import BidList from '../components/BidList'

  export default {
    name: 'BillDetail',
    components: {
      BillCard,
      BidList
    },
    props: ['id'],
    computed: {
      ...mapState(['bills']),
      activeBill() {
        return this.$store.getters.ActiveBill
      }
    },
    mounted() {
      if (this.bills.data[0].bill.data.attributes.id === null) {
        this.$store.dispatch('GET_BILL', this.id)
      } else {
        this.$store.commit('SET_ACTIVE_BILL', this.id)
      }
    }
  }
</script>

