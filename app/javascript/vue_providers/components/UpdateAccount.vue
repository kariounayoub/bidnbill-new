<template>
  <div>
    <v-form ref="form" v-model="valid" lazy-validation>
      <v-card class="rounded">
        <v-card-title class="headline sm">
          <span>Modifier Compte</span>
        </v-card-title>

        <v-card-text>
          <div class="mx-3">
            <div class="image-input">
              <div class="profile-img" v-if="!editImg">
                <img :src="picture" alt="logo" />
                <button
                  color="primary"
                  @click="editImg = true"
                  title="Modifier votre photo de profil"
                >
                  <v-icon color="primary">edit</v-icon>
                </button>
              </div>
              <SingleFileUploader
                v-on:inputChange="handleInputChange"
                name="picture"
                backgroundImg
                inputText="Glissez votre logo ici"
                minHeight="100px"
                dropMargin="0px"
                pMargin="10px"
                v-if="editImg"
              />
            </div>

            <v-text-field
              v-model="company"
              :rules="[required]"
              label="Companie"
            />
            <v-textarea
              v-model="description"
              :rules="[required]"
              label="Déscription"
            />
            <v-text-field
              v-model="phone"
              :rules="[required, isPhone]"
              label="Numéro de Téléphone"
            />
            <v-text-field v-model="address" label="Adresse" />
            <v-text-field v-model="city" label="Ville" />
            <v-text-field v-model="post_code" label="code_postal" />
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" flat @click="$emit('close')">Fermer</v-btn>
          <v-btn color="primary" flat @click="handleValidate">Valider</v-btn>
        </v-card-actions>
      </v-card>
    </v-form>
  </div>
</template>

<script>
import { required, isPhone } from "../../shared_components/validate";
import SingleFileUploader from "../../shared_components/SingleFileUploader";
export default {
  name: "UpdateAccount",
  components: {
    SingleFileUploader
  },
  data: () => ({
    required: required,
    isPhone: isPhone,
    company: null,
    description: null,
    phone: null,
    valid: false,
    editImg: false,
    picture: null,
    address: null,
    city: null,
    post_code: null
  }),
  computed: {
    account() {
      return this.$store.getters.Account.attributes;
    }
  },
  methods: {
    handleValidate() {
      if (this.$refs.form.validate()) {
        const formData = {
          account: {
            company: this.company,
            description: this.description,
            phone_number: this.phone,
            picture: this.picture,
            address: this.address,
            city: this.city,
            post_code: this.post_code
          }
        };
        console.log(formData);
        this.$store.dispatch("UPDATE_ACCOUNT", formData);
      }
      this.$emit("close");
    },
    handleInputChange(field, data) {
      this[field] = data.data;
    }
  },
  mounted() {
    this.company = this.account.company;
    this.description = this.account.description;
    this.phone = this.account.phone_number;
    this.picture = this.account.picture;
    this.address = this.account.address;
    this.city = this.account.city;
    this.post_code = this.account.post_code;
  }
};
</script>
