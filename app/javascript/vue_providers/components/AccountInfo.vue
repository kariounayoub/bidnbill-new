<template>
  <div class="AccountInfo">
    <img :src="logo" :alt="info.company" class="provider-img" />
  </div>
</template>

<script>
import getProviderImage from "../../vue_clients/get_provider_image";
export default {
  name: "AccountInfo",
  computed: {
    info() {
      return this.$store.getters.Account.attributes;
    },
    logo() {
      return getProviderImage(this.info.company);
    }
  }
};
</script>

<style scoped lang='scss'>
.AccountInfo {
  margin: 0 0 20px 0;
  display: flex;
  justify-content: center;
}
.provider-img {
  height: 120px;
  width: 120px;
  object-fit: contain;
  margin: 20px 0;
}
</style>