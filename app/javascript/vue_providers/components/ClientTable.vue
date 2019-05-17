<template>
  <div>
      <v-card class='rounded'>
        <v-layout row wrap class='inside-card'>
          <v-flex xs12 sm6 >
            <v-text-field
              class="with-margin"
              append-icon="search"
              label="Ville"
              single-line
              hide-details
              @input="filterVilles"
            ></v-text-field>
          </v-flex>
          <v-flex xs12 sm6 >
            <v-select
              class="with-margin"
              :items="statuses"
              label="Status"
              @change="filterStatus"
            ></v-select>
          </v-flex>
          <v-flex xs12>
            <v-data-table :headers="headers":items="clients" item-key="title" :rows-per-page-items="[10,25,50,100]" rows-per-page-text="Résultats par page" must-sort :search="filters" :custom-filter="customFilter">
              <template v-slot:items="props">
                <tr @click='setActiveClient(props.item.bill.data.id)' :class="isActive(props.item.bill.data.id) ? 'selected' : ''">
                  <td class="text-xs-left" >{{props.item.bill.data.attributes.category.name}}</td>
                  <td class="text-xs-right">{{props.item.client.data.attributes.full_name}}</td>
                  <td class="text-xs-right">{{props.item.bill.data.attributes.city}}</td>
                  <td class="text-xs-right">test</td>
                  <td class="text-xs-right pointer"><v-icon>visibility</v-icon></td>
                </tr>
              </template>
            </v-data-table>
          </v-flex>
        </v-layout>
      </v-card>
  </div>
</template>

<script>

import providers from '../../shared_components/providers'

export default {
  name: 'BidTable',
  props: ['clients'],
  data: () => ({
    filters: {
      ville: '',
      status: '',
    },
    statuses: ['Tout','Terminé', 'En cours', 'Refusé'],
    headers: [
      { text: 'Demande', align: 'left', value: 'category'},
      { text: 'Nom', value: 'current_provider', align: 'right'},
      { text: 'Ville', value: 'city', align: 'right'},
      { text: 'Statut', value: 'status', align: 'right'},
      { text: 'Actions', value: 'actions', align: 'right'},
    ],
  }),
  computed: {
    activeClient() {
      return this.$store.getters.ActiveClient
    }
  },
  methods: {
    customFilter(items, filters, filter, headers) {
      const cf = new this.$MultiFilters(items, filters, filter, headers);

      cf.registerFilter('ville', function(searchWord, items) {
        if (searchWord.trim() === "") return items;

        return items.filter(item => {
          if (item.city === null) return ''
          return item.bill.data.attributes.city.toLowerCase().includes(searchWord.toLowerCase());
        }, searchWord)
      });

      cf.registerFilter('status', function(status, items) {
        if(status.trim() === '') return items;
        if (status.trim() === "Tout") return items;

        return items.filter(item => {
          return item.bid.data.attributes.status.toLowerCase() === status.toLowerCase();
        }, status)
      });

      return cf.runFilters();
    },
    filterVilles(val) {
      this.filters = this.$MultiFilters.updateFilters(this.filters, {ville: val});
    },
    filterStatus(val) {
      this.filters = this.$MultiFilters.updateFilters(this.filters, {status: val});
    },
    setActiveClient(billId) {
      this.$store.commit('SET_ACTIVE_CLIENT', billId)
    },
    isActive(id) {
      if (this.activeClient === null) {
        return false
      } else {
        return  parseInt(this.activeClient.bill.data.id) === parseInt(id)
      }
    },
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
  .selected {
    background-color: rgba(89,224,42,0.3);
  }

</style>
