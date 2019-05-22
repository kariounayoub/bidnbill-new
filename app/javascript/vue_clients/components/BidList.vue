<template>
  <div>
    <v-card class='user_card rounded'>
      <div class="card__title">Mes offres</div>
        <v-data-table
          id='my-datatable'
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
            <td class="text-xs-center status-width"> <span class='status-tag' v-bind:class='statusClass(props.item.bid.status)'>{{ props.item.bid.status }}</span></td>
            <td class="text-xs-center"><v-btn small class='rounded' @click='selectBid(props.item.bid.id)' v-if='activeBill.attributes.is_open && !props.item.bid.needs_editing'>Accépter</v-btn><span v-if='props.item.bid.needs_editing && activeBill.attributes.is_open'>En attente de validation suite à votre modification</span></td>
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
          { text: 'Fournisseur', value: 'account.company',  class: 'bid__header'},
          { text: 'Offre', value: 'bid.price',  class: 'bid__header'},
          { text: 'Economies', value: 'savings',  class: 'bid__header'},
          { text: 'Statut', value: 'bid.status', class: 'bid__header', align: 'center' },
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
        return this.activeBill.attributes.standardized_price - bidPrice
      },
      selectBid(id) {
        this.$store.dispatch('SELECT_BID', id)
      },
      statusClass(status) {
        if (status === 'refusé') return 'error'
        if (status === 'en attente') return 'warning'
        if (status === 'accépté') return 'success'
      }
    }

  }
</script>

<style scoped lang='scss'>
    .card__title {
      background: linear-gradient(234.15deg, var(--v-success-base) -28.36%, #FFFFFF 171.84%);
      width: 100%;
      border-radius: 30px 4px 0px 0px ;
      font-size: 18px;
      padding: 7px;
      font-weight: 700;
      color: white;
      text-align: center;
    }
</style>

