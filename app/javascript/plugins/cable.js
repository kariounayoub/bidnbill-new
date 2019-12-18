import Vue from "vue";
import ActionCableVue from "actioncable-vue";

Vue.use(ActionCableVue, {
  debug: true,
  debugLevel: "error",
  connectionUrl:
    process.env.NODE_ENV === "development"
      ? "ws://localhost:3000/cable"
      : "wss://bidnbill-new.herokuapp.com/cable",
  connectImmediately: true
});
