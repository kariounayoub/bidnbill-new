<template>
  <div>
    <div class='form-title'>
      <h4>Etape 2/3</h4>
      <p>Téléchargez votre facture ou remplissez le formulaire de consommation</p>
      <v-container fluid>
        <v-layout row wrap>
          <v-flex xs12 sm4>
            <div class='upload-invoice-wrapper'>
              <div class="flex-center flex-column"   >
                <div class="download-icon" >
                  <i class="fas fa-file-invoice"></i>
                </div>
                <p>Téléchargez Facture</p>
              </div>
            </div>
          </v-flex>
          <v-flex xs12 sm8 id='form-fields'>
            <div >
              <div class="form-subtitle inline-div">Vôtre fournisseur actuel</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="current_provider" outline/>
              </div>
            </div>

            <div >
              <div class="form-subtitle inline-div">Fréquence de paiement</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="frequency" outline/>
              </div>
            </div>

            <div >
              <div class="form-subtitle inline-div">Prix TTC</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="price" outline/>
              </div>
            </div>

            <div >
              <div class="form-subtitle inline-div">Vôtre addresse</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="address" outline/>
              </div>
            </div>

            <div >
              <div class="form-subtitle inline-div">Consommation annuelle (KW/h)</div>
              <div class="form-content inline-div">
                  <v-text-field v-model="consumption" outline/>
              </div>
            </div>

          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'BillFormStep2',
    data: () => ({
      current_provider: null,
      frequency: null,
      price: null,
      address: null,
      consumption: null
    })
  }
</script>


<style scoped lang='scss'>
  .upload-invoice-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
    border-right: 2px solid var(--v-success-base);
    font-size: 16px;
    font-weight: 700;
    color: rgba(0,0,0,0.8);
  }

  .download-icon {
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 120px;
    height: 120px;
    border-radius: 5%;
    color: var(--v-success-base);
    border: 2px solid var(--v-success-base);
    margin-bottom: 5px;
    i {
      font-size: 60px;
    }
  }

  .form-subtitle {
    color: #777;
    width: 49%;
    text-align: left;
    padding-bottom: 10px;
    padding-left: 10%;
    font-weight: 700;
    font-size: 14px;
  }
  .form-content {
    width: 50%;
  }
</style>

<style>
  #form-fields .v-input input {
    max-height: none;
  }
  #form-fields .v-text-field--outline input {
    margin-top: 0;
  }


</style>
