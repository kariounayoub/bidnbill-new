<template>
  <div>
    <div v-if="flash.show && flash.variant === 'success'" role="alert" aria-live="polite" aria-atomic="true" class="show-alert alert alert-success offset" >
      <button type="button" data-dismiss="alert" aria-label="alertClose" class="close" @click="closeFlash()"><span aria-hidden="true">x</span></button>
      {{flash.message}}
    </div>
    <div v-if="flash.show && flash.variant === 'warning'" role="alert" aria-live="polite" aria-atomic="true" class="show-alert alert alert-warning offset" >
      <button type="button" data-dismiss="alert" aria-label="alertClose" class="close" @click="closeFlash()"><span aria-hidden="true">x</span></button>
      {{flash.message}}
    </div>
    <div v-if="flash.show && flash.variant === 'error'" role="alert" aria-live="polite" aria-atomic="true" class="show-alert alert alert-error offset" >
      <button type="button" data-dismiss="alert" aria-label="alertClose" class="close" @click="closeFlash()"><span aria-hidden="true">x</span></button>
      {{flash.message}}
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Flash',
    data: () => ({
      flash: {
        message: null,
        show: false,
        variant: null,
      }
    }),
    computed: {
      stateflash() {
        return this.$store.getters.Flash
      },
    },
    methods: {
      closeFlash() {
        this.$store.commit('SET_FLASH', null)
      }
    },
    watch: {
      stateflash() {
        if (this.stateflash !== null) {
          this.flash = {message: this.stateflash.message, show: true, variant: this.stateflash.variant}
        } else {
          this.flash = {message: null, show: false, variant: null}
        }
      }
    }
  }
</script>
