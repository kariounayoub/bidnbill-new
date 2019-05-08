<template>
  <div>
    <div class='form-title'>
      <h4>Etape 1/3</h4>
      <p>Sélectionnez le type d’abonnement pour lequel vous souhaitez créer un enchère</p>
    </div>
      <div class="choix-type">
        <div class="text-center"  @click="setBillType('Electricité')" >
          <div class="type-icon d-flex align-items-center justify-content-center" v-bind:class="{'chosen-icon' : billType === 'Electricité'}">
            <i class="far fa-lightbulb"></i>
          </div>
          <p>Electricté</p>
        </div>
        <div class="text-center"  @click="setBillType('Gaz')" >
          <div class="type-icon d-flex align-items-center justify-content-center" v-bind:class="{'chosen-icon' : billType === 'Gaz'}">
            <i class="fas fa-burn"></i>
          </div>
          <p>Gaz</p>
        </div>
        <div class="text-center"   @click="setBillType('Electricité et Gaz')" >
          <div class="type-icon d-flex align-items-center justify-content-center" v-bind:class="{'chosen-icon' : billType === 'Electricité et Gaz'}">
            <i class="far fa-lightbulb"></i> + <i class="fas fa-burn"></i>
          </div>
          <p>Electricté et Gaz</p>
        </div>
      </div>
      <div class="choix-type-even">
        <div class="text-center" >
          <p>Comming Soon...</p>
          <div class="type-icon dark d-flex align-items-center justify-content-center">
            <i class="fas fa-phone"></i>
          </div>
          <p>Téléphone</p>
        </div>
        <div class="text-center" >
          <p>Comming Soon...</p>
          <div class="type-icon dark d-flex align-items-center justify-content-center" >
            <i class="fas fa-wifi"></i>
          </div>
          <p>Internet</p>
        </div>
      </div>

    <!-- Hidden Select Field -->
    <v-select
      attach
      class="d-none"
      v-model="billType"
      :items="categoryList"
      :rules="[v => !!v || 'Champs Obligatoire']"
      required
    ></v-select>


  </div>
</template>

<script>
  export default {
    name: 'BillFormStep1',
     data: () => ({
      valid: true,
      billType: '',
      categoryList: ['Electricité', 'Gaz', 'Electricité et Gaz', 'Téléphone', 'Internet'],
    }),
    methods: {
      setBillType (value) {
        this.billType = value
      }
    }

  }
</script>

<style scoped lang='scss'>


  .choix-type-even {
    display: flex;
    justify-content: space-evenly;
    padding-top: 20px;
  }

  .choix-type {
    display: flex;
    justify-content: space-around;
    padding-top: 20px;

  }

  .type-icon {
    cursor: pointer;
    width: 120px;
    height: 120px;
    border-radius: 50%;
    background-color: #ccc;
    font-size: 40px;
    i {
      font-size: 40px;
    }
  }
  .dark {
    background-color: #eee;
    color: #ccc;
  }
  .chosen-icon {
    background-color: var(--v-success-base);
    color :white;
    i {
      color: white;
    }
  }

   p {
     font-size: 14px;
     padding: 5px 0;
   }

    @media only screen and (max-device-width: 600px) {
      .choix-type {
        flex-direction: column;
        align-items: center;
      }
      .choix-type-even {
        flex-direction: column;
        align-items: center;
      }
    }


</style>
