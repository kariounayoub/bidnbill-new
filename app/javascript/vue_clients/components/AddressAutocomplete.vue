<template>
    <v-combobox
      v-model="address"
      :items="items"
      :search-input.sync="search"
      hide-no-data
      hide-selected
      :label='Label'
      :outline='outlined'
      :rules="[required]"
       @change="[$emit('input', address)]"
    ></v-combobox>
</template>

<script>
  import axios from 'axios'
  import {required, number} from '../../shared_components/validate'

  export default {
    name: 'AddressAutocomplete',
    props: {
      initAddress: {type: String, default: null},
      outlined: {type: Boolean, default: false},
      Label: {type: String, default: 'Address'}
    },
    data: () => ({
      required: required, number: number,
      address: null,
      entries: [],
      search: false,
    }),

    computed: {
      items () {
        return this.entries.map(e => e.properties.label)
      },
    },
    mounted() {
      this.address = this.initAddress
    },
   watch: {
    search (val) {
      // Lazily load input items
      if (val === null) val = 'a'
      axios.get(`https://api-adresse.data.gouv.fr/search/?q=${val}`)
        .then(res => {
          this.entries = res.data.features
        })
        .catch(err => {
          console.log(err)
        })
        .finally(() => (this.$emit('changeCity', this.entries[0].properties.city)))
      },
    },
  }
</script>
