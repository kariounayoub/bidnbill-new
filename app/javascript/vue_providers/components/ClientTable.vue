<template>
  <div>
    <v-card class="rounded">
      <v-layout row wrap class="inside-card">
        <v-flex xs12 sm6>
          <v-text-field
            class="with-margin"
            append-icon="search"
            label="Ville"
            single-line
            hide-details
            @input="filterVilles"
          ></v-text-field>
        </v-flex>
        <v-flex xs12 sm6>
          <v-select
            class="with-margin"
            :items="statuses"
            label="Status"
            @change="filterStatus"
          ></v-select>
        </v-flex>
        <v-flex xs12>
          <v-data-table
            :headers="headers"
            :items="clients"
            item-key="title"
            :rows-per-page-items="[10, 25, 50, 100]"
            rows-per-page-text="Résultats par page"
            must-sort
            :search="filters"
            :custom-filter="customFilter"
            id="my-datatable"
          >
            <template v-slot:items="props">
              <tr
                @click="setActiveClient(props.item.bill.data.id)"
                :class="isActive(props.item.bill.data.id) ? 'selected' : ''"
              >
                <td class="text-xs-left">
                  {{ props.item.bill.data.attributes.category.name }}
                </td>
                <td class="text-xs-right">
                  {{ props.item.client.data.attributes.full_name }}
                </td>
                <td class="text-xs-right">
                  {{ props.item.bill.data.attributes.city }}
                </td>
                <td class="text-xs-center">
                  <span
                    class="status-tag"
                    v-bind:class="
                      statusClass(props.item.bid.data.attributes.client_status)
                    "
                    >{{ props.item.bid.data.attributes.client_status }}</span
                  >
                </td>
                <td class="text-xs-right pointer" @click="dialog = true">
                  <v-icon>visibility</v-icon>
                </td>
              </tr>
            </template>
          </v-data-table>
        </v-flex>
      </v-layout>
    </v-card>
    <!-- Dialog -->
    <v-dialog v-model="dialog" max-width="700px" v-if="activeClient !== null">
      <EditClientStatusDialog
        v-bind:client="activeClient"
        v-on:close="dialog = false"
      />
    </v-dialog>
  </div>
</template>

<script>
import providers from "../../shared_components/providers";
import EditClientStatusDialog from "./EditClientStatusDialog";
export default {
  name: "ClientTable",
  props: ["clients"],
  components: {
    EditClientStatusDialog
  },
  data: () => ({
    dialog: false,
    filters: {
      ville: "",
      status: ""
    },
    statuses: [
      "Tout",
      "Nouveau",
      "A Contacter",
      "Contact en cours",
      "Contact Refusé",
      "Contact Accépté"
    ],
    headers: [
      {
        text: "Demande",
        align: "left",
        value: "bill.data.attributes.category.name"
      },
      {
        text: "Nom",
        value: "client.data.attributes.full_name",
        align: "right"
      },
      { text: "Ville", value: "bill.data.attributes.city", align: "right" },
      {
        text: "Statut",
        value: "bid.data.attributes.client_status",
        align: "center"
      },
      { text: "Actions", value: "actions", align: "right" }
    ]
  }),
  computed: {
    activeClient() {
      return this.$store.getters.ActiveClient;
    }
  },
  methods: {
    statusClass(status) {
      if (status === "Nouveau") return "success";
      if (status === "A Contacter") return "warning";
      if (status === "Contact en cours") return "warning";
      if (status === "Contact Refusé") return "error";
      if (status === "Contact Accépté") return "success";
      return "";
    },

    customFilter(items, filters, filter, headers) {
      const cf = new this.$MultiFilters(items, filters, filter, headers);

      cf.registerFilter("ville", function(searchWord, items) {
        if (searchWord.trim() === "") return items;

        return items.filter(item => {
          if (item.city === null) return "";
          return item.bill.data.attributes.city
            .toLowerCase()
            .includes(searchWord.toLowerCase());
        }, searchWord);
      });

      cf.registerFilter("status", function(status, items) {
        if (status.trim() === "") return items;
        if (status.trim() === "Tout") return items;

        return items.filter(item => {
          return (
            item.bid.data.attributes.client_status.toLowerCase() ===
            status.toLowerCase()
          );
        }, status);
      });

      return cf.runFilters();
    },
    filterVilles(val) {
      this.filters = this.$MultiFilters.updateFilters(this.filters, {
        ville: val
      });
    },
    filterStatus(val) {
      this.filters = this.$MultiFilters.updateFilters(this.filters, {
        status: val
      });
    },
    setActiveClient(billId) {
      this.$store.commit("SET_ACTIVE_CLIENT", billId);
    },
    isActive(id) {
      if (this.activeClient === null) {
        return false;
      } else {
        return parseInt(this.activeClient.bill.data.id) === parseInt(id);
      }
    }
  }
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
  background-color: rgba(126, 172, 247, 0.4);
}
</style>
