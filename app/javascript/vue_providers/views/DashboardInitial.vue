<template>
  <div>
    <h3 class="dashboard__title">Enchères en cours</h3>
    <v-container>
      <v-card class='rounded'>
        <v-layout row wrap class='inside-card'>
          <v-flex xs4 >
            <v-select
              class="with-margin"
              :items="categories"
              label="Demande"
              @change="filterDemandes"
            ></v-select>
          </v-flex>
          <v-flex xs4 >
            <v-text-field
              class="with-margin"
              append-icon="search"
              label="Ville"
              single-line
              hide-details
              @input="filterVilles"
            ></v-text-field>
          </v-flex>
          <v-flex xs4 >
            <v-select
              class="with-margin"
              :items="providers"
              label="Fournisseurs"
              @change="filterFournisseurs"
            ></v-select>
          </v-flex>
          <v-flex xs12>
            <v-data-table :headers="headers":items="items" item-key="title" :rows-per-page-items="[10,25,50,100]" rows-per-page-text="Résultats par page" must-sort :search="filters" :custom-filter="customFilter">
              <template v-slot:items="props">
                <tr >
                  <td class="text-xs-left" >{{ props.item.category.name }}</td>
                  <td class="text-xs-right">{{ props.item.current_provider }}</td>
                  <td class="text-xs-right">{{ props.item.price }} €</td>
                  <td class="text-xs-right">{{ props.item.city }}</td>
                  <td class="text-xs-right">{{ bidCount(props.item) }}</td>
                  <td class="text-xs-right">Bid</td>
                </tr>
              </template>
            </v-data-table>
          </v-flex>
        </v-layout>
      </v-card>
    </v-container>
  </div>
</template>

<script>

import { mapState } from 'vuex'
import providers from '../../shared_components/providers'

export default {
  name: 'DashboardInitial',
  data: () => ({
    filters: {
      ville: '',
      demande: '',
      fournisseur: '',
    },
    categories: ['Tout','Electricité', 'Gaz', 'Electricité et Gaz'],
    providers: ['Tout',...providers],
    headers: [
      { text: 'Demande', align: 'left', value: 'category'},
      { text: 'Fournisseur actuel', value: 'current_provider', align: 'right'},
      { text: 'Abonnement en cours', value: 'current_price', align: 'right'},
      { text: 'Ville', value: 'city', align: 'right'},
      { text: 'Statut', value: 'status', align: 'right'},
      { text: 'Actions', value: 'actions', align: 'right'},
    ],
  }),
  computed: {
    bills() {
      return this.$store.getters.Bills
    },
    items() {
      return this.bills.map(e => e.attributes)
    }
  },
  methods: {
    bidCount(bill) {
      return `${bill.bids.length} enchères en cours`;
    },
    customFilter(items, filters, filter, headers) {
      const cf = new this.$MultiFilters(items, filters, filter, headers);

      cf.registerFilter('ville', function(searchWord, items) {
        if (searchWord.trim() === "") return items;
        if (searchWord.trim() === "Tout") return items;

        return items.filter(item => {
          return item.city.toLowerCase().includes(searchWord.toLowerCase());
        }, searchWord)
      });

      cf.registerFilter('demande', function(demande, items) {
        if(demande.trim() === '') return items;
        if (demande.trim() === "Tout") return items;

        return items.filter(item => {
          return item.category.name.toLowerCase() === demande.toLowerCase();
        }, demande)
      });

      cf.registerFilter('fournisseur', function(fournisseur, items) {
        if(fournisseur.trim() === '') return items;
        if (fournisseur.trim() === "Tout") return items;

        return items.filter(item => {
          return item.current_provider.toLowerCase() === fournisseur.toLowerCase();
        }, fournisseur)
      });

      return cf.runFilters();
    },
    filterVilles(val) {
      this.filters = this.$MultiFilters.updateFilters(this.filters, {ville: val});
    },
    filterDemandes(val) {
      this.filters = this.$MultiFilters.updateFilters(this.filters, {demande: val});
    },
    filterFournisseurs(val) {
      this.filters = this.$MultiFilters.updateFilters(this.filters, {fournisseur: val});
    }
  },
  mounted() {
    if (this.bills[0].attributes.id === null) {
      this.$store.dispatch('GET_BILLS')
    }
  },

};
</script>

<style scoped lang="scss">
  .inside-card {
    padding: 20px;
  }
  .with-margin {
    margin: 0 15px;
  }

</style>
