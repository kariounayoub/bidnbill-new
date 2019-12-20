<template>
  <v-card class="rounded">
    <v-form ref="form" v-model="valid" lazy-validation>
      <v-card-title class="headline">
        <span>Enchérir</span>
      </v-card-title>
      <v-card-text>
        <v-container grid-list-md>
          <v-layout wrap>
            <v-flex xs12>
              <v-text-field
                label="Prix (mensuelle)"
                v-model="price"
                :rules="[required, number]"
              ></v-text-field>
            </v-flex>
            <v-flex xs12>
              <v-textarea
                label="Présentation de l'offre"
                v-model="content"
              ></v-textarea>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="primary darken-1" flat @click="$emit('close')"
          >Fermer</v-btn
        >
        <v-btn
          color="primary darken-1"
          flat
          v-if="canBid"
          @click="saveBid('create')"
          >Enregistrer</v-btn
        >
        <v-btn
          color="primary darken-1"
          flat
          v-if="myBidNeedsEditing()"
          @click="saveBid('edit')"
          >Enregistrer</v-btn
        >
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { required, number } from "../../shared_components/validate";

export default {
  name: "BiddingForm",
  props: {
    canBid: Boolean,
    myBidNeedsEditing: Function,
    myBid: Object,
    viewedBill: Object
  },
  data: () => ({
    required: required,
    number: number,
    valid: false,
    price: null,
    content: null
  }),
  methods: {
    saveBid(type) {
      if (this.$refs.form.validate()) {
        const formData = {
          bid: {
            bill_id: this.viewedBill.id,
            price: this.price,
            content: this.content,
            user_id: this.$store.getters.Provider.attributes.id
          }
        };
        this.$emit("close");
        this.$emit("closeAll");
        if (type === "create") {
          this.$store.dispatch("CREATE_BID", formData);
        }
        if (type === "edit") {
          formData.bid_id = this.myBid.bid.id;
          this.$store.dispatch("UPDATE_BID", formData);
        }
      }
    }
  },
  mounted() {
    if (!this.canBid) {
      this.price = this.myBid.bid.price;
      this.content = this.myBid.bid.content;
    }
  }
};
</script>
