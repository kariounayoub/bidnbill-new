<template>
  <div>
    <v-card class='bid__card'>
      <div class="bid__card__title">Mes offres</div>
        <v-data-table
          id='bid-datatable'
          :headers="headers"
          :items="bids"
          :rows-per-page-text="'Résultats par page'"
          :no-data-text="'Aucune donnée disponible'"
          :rows-per-page-items="[5,10,25,{'text': 'Tout', 'value': -1}]"
        >
          <template v-slot:items="props">
            <td class="text-xs-left">{{ props.item.account.company }} </td>
            <td class="text-xs-left">{{ props.item.bid.price }} €</td>
            <td class="text-xs-left">{{ calculateDifference(props.item.bid.price) }} €</td>
            <td class="text-xs-left">{{ props.item.bid.status }}</td>
            <td class="text-xs-left"><v-btn small color='success' @click='selectBid(props.item.bid.id)' v-if='activeBill.attributes.is_open'>Accépter</v-btn></td>
          </template>
        </v-data-table>
    </v-card>
  </div>
</template>

<script>
  export default {
    name: 'BidList',
    props: ['bids'],
    data: ()=> ({
        headers: [
          { text: 'Fournisseur', value: 'provider',  class: 'bid__header'},
          { text: 'Offre', value: 'bid',  class: 'bid__header'},
          { text: 'Economies', value: 'savings',  class: 'bid__header'},
          { text: 'Statut', value: 'status', class: 'bid__header' },
          { text: 'Actions', value: 'actions',  class: 'bid__header'}
        ],
    }),
    computed: {
      activeBill () {
        return this.$store.getters.ActiveBill;
      },
    },
    methods: {
      calculateDifference(bidPrice) {
        return this.activeBill.attributes.price - bidPrice
      },
      selectBid(id) {
        this.$store.dispatch('SELECT_BID', id)
      }
    }

  }
</script>

<style scoped lang='scss'>
  .bid__card {
    margin: 20px;
    border-radius: 30px 4px 30px 4px;
    .bid__card__title {
      background: linear-gradient(234.15deg, var(--v-success-base) -28.36%, #FFFFFF 171.84%);
      width: 100%;
      border-radius: 30px 4px 0px 0px ;
      font-size: 18px;
      padding: 7px;
      font-weight: 700;
      color: white;
      text-align: center;
    }
  }
</style>

<style lang='scss'>
    #bid-datatable table.v-table thead th{
       font-size: 14px !important;
        font-weight: 700;
    }
    #bid-datatable {
        border-radius: 0 0 30px 4px !important;
      .v-datatable {
        border-radius: 0 0 30px 4px !important;
      }
      .v-datatable__actions {
        border-radius: 0 0 30px 4px !important;
      }
    }
</style>
