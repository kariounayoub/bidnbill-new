<template>
  <MglMap v-if='coordinates !== null' class="rounded" :accessToken="accessToken" :mapStyle="'mapbox://styles/mapbox/streets-v10'" :center="coordinates" :zoom='12'>
    <MglMarker  :coordinates="coordinates" color="green" />
  </MglMap>
</template>

<script>
  import Mapbox from "mapbox-gl";
  import { MglMap, MglMarker } from "vue-mapbox";

  export default {
    name: 'Map',
    props: ['accessToken', 'coordinates'],
    components: {
      MglMap,
      MglMarker
    },
    created() {
      // We need to set mapbox-gl library here in order to use it in template
      this.mapbox = Mapbox;
    }
  }
</script>
