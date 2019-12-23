<template>
  <div>
    <v-card class="rounded">
      <v-card-title class="headline sm">
        <span>{{ title }}</span>
      </v-card-title>
      <v-card-text>{{ text }}</v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="primary" flat @click="$emit('close')">Ok</v-btn>
      </v-card-actions>
    </v-card>
  </div>
</template>

<script>
export default {
  name: "InfoDialog",
  props: {
    title: String,
    text: String
  }
};
</script>
