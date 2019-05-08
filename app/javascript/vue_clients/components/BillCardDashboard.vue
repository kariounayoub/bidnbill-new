<template>
  <div>
    <v-card class="dashboard__card">
      <v-layout justify-content-between>
        <div class='dashboard__card__right'>
          <div class="card-category"><i class="fas fa-lightbulb"></i>  {{bill.attributes.category.name}}</div>
          <div class="card-info">
            <h4>{{bill.attributes.current_provider}}</h4>
            <p>{{bill.attributes.price}} € / mois</p>
          </div>
          <router-link  :to="'/bills/' + bill.id">
            <v-btn class='rounded'>Mes offres</v-btn>
          </router-link>
        </div>
        <div class="dashboard__card__left">
          <div class="dashboard_card_image" v-bind:style="{backgroundImage: 'url(' + getImage + ')'}"></div>
        </div>
      </v-layout>
    </v-card>
  </div>
</template>

<script>
  import getProviderImage from '../get_provider_image.js';

  export default {
    name: 'Bill',
    props: ['bill'],
    computed: {
      getImage() {
         return getProviderImage(this.bill.attributes.current_provider)
      }
    }
  }
</script>

<style scoped lang='scss'>
  .dashboard__card {
    margin: 20px;
    border-radius: 30px 4px 30px 4px;
    .dashboard__card__right {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: space-between;
      width: 50%;
      .card-category {
        padding-top: 20px;
        font-size: 20px;
        color: var(--v-success-base);
        font-weight: 600;
      }
      .card-info {
        text-align: center;
        h4 {
          font-weight: 600;
          color: rgba(0,0,0,0.8)
        }
      }
      button {
        margin-bottom: 20px;
      }
    }
    .dashboard__card__left {
      height: 200px;
      background: linear-gradient(234.15deg, var(--v-success-base) -28.36%, #FFFFFF 171.84%);
      width: 50%;
      display: flex;
      align-items: center;
      border-radius: 0 4px 30px 0;
      .dashboard_card_image {
        height: 50%;
        width: 100%;
        background-repeat: no-repeat;
        background-size: contain;
        background-position: center;
      }
    }
    a:hover {
      text-decoration: none;
    }
  }
</style>
