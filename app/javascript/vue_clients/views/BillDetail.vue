<template>
  <div>
    <h3 class="dashboard__title">Abonnement {{activeBill.attributes.current_provider}}</h3>
    <v-container>
      <div  v-if='!activeBill.attributes.is_open' class='bids-closed'>
        <h5>Les enchères sont fermé pour cette abonnement. Vous avez déja séléctionner un nouveau fournisseur</h5>
      </div>
      <v-layout row wrap>
        <v-flex xs12 sm4>
          <BillCard v-bind:bill='activeBill' />
        </v-flex>
        <v-flex xs12 sm8>
          <BidList v-bind:bids='activeBill.attributes.bids'/>
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
      BidList,
    },
    data: () => ({
      interval: null,
    }),
    props: ['id'],
    computed: {
      ...mapState(['bills']),
      activeBill() {
        return this.$store.getters.ActiveBill
      }
    },

    mounted() {
      this.$store.dispatch('GET_BILL', this.id)
      this.interval = setInterval(() => {
          this.$store.dispatch('GET_BILL', this.id)
        }, 10000);
    },
    beforeDestroy() {
      clearInterval(this.interval)
    }
  }
</script>

<style scoped lang='scss'>
  .bids-closed {
    text-align: center;
    background-color: var(--v-primary-base);
    border-radius: 15px 2px 15px 2px;
    h5 {
      font-size: 14px;
      font-weight: bold;
      color: white;
      padding: 15px;
    }
  }
  .edit-position {
    position: relative;
    left: 10%;
  }
  @media only screen and (max-width: 600px) {
    .edit-position {
      left: 30%;
    }
  }
</style>
