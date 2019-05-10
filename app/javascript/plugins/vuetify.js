import Vue from 'vue';
import Vuetify from 'vuetify';
import '../stylus/main.styl';
import '@mdi/font/css/materialdesignicons.css';

Vue.use(Vuetify, {
  options: {
    customProperties: true
  },
  theme: {
    primary: '#4caf50',
    secondary: '#4caf50',
    tertiary: '#495057',
    accent: '#82B1FF',
    error: '#f55a4e',
    info: '#00d3ee',
    success: '#59E02A',
    warning: '#ffa21a',
  }

});
