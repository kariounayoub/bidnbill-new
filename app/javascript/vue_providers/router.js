import Vue from "vue";
import Router from "vue-router";
import store from "./store/index";

import DashboardInitial from "./views/DashboardInitial.vue";
import ProviderEncheres from "./views/ProviderEncheres.vue";
import ProviderClients from "./views/ProviderClients.vue";
import LostBills from "./views/LostBills.vue";
import EditAccount from "./views/EditAccount.vue";
import EditProvider from "./views/EditProvider.vue";

Vue.use(Router);

export default new Router({
  mode: "history",
  base: process.env.BASE_URL,
  routes: [
    {
      path: "/provider_dashboard",
      name: "dashboard",
      component: DashboardInitial
    },
    {
      path: "/provider_encheres",
      name: "providerEncheres",
      component: ProviderEncheres
    },
    {
      path: "/provider_encheres_lost",
      name: "providerEncheresLost",
      component: LostBills
    },
    {
      path: "/provider_clients",
      name: "providerClients",
      component: ProviderClients
    },
    {
      path: "/edit_provider",
      name: "edit_provider",
      component: EditProvider
    },
    {
      path: "/edit_account",
      name: "edit_account",
      component: EditAccount,
      beforeEnter: (to, from, next) => {
        if (store.state.provider.data.attributes.account_admin === false) {
          next(false);
        } else {
          next();
        }
      }
    }
  ],
  scrollBehavior() {
    return { x: 0, y: 0 };
  }
});
