import Vue from 'vue';
import Router from 'vue-router';
import DashboardInitial from './views/DashboardInitial.vue';
import ProviderEncheres from './views/ProviderEncheres.vue';
import ProviderClients from './views/ProviderClients.vue';
import LostBills from './views/LostBills.vue';
import EditUser from './views/EditUser.vue';


Vue.use(Router);

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/provider_dashboard',
      name: 'dashboard',
      component: DashboardInitial,
    },
    {
      path: '/provider_encheres',
      name: 'providerEncheres',
      component: ProviderEncheres,
    },
    {
      path: '/provider_encheres_lost',
      name: 'providerEncheresLost',
      component: LostBills,
    },
    {
      path: '/provider_clients',
      name: 'providerClients',
      component: ProviderClients,
    },
    {
      path: '/users/edit_provider',
      name: 'edit_provider',
      component: EditUser,
    },
  ],
});
