import Vue from "vue";
import Vuetify from "vuetify";
import "../stylus/main.styl";
import "@mdi/font/css/materialdesignicons.css";

Vue.use(Vuetify, {
  iconfont: "md",
  options: {
    customProperties: true
  },
  theme: {
    primary: "#1c3358",
    secondary: "#9a8b3f",
    tertiary: "#495057",
    accent: "#82B1FF",
    error: "#f55a4e",
    info: "#00d3ee",
    success: "#59E02A",
    warning: "#ffa21a"
  }
});
