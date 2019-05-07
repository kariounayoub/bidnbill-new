import Vue from 'vue';
import Router from 'vue-router';
import DashboardInitial from './views/DashboardInitial.vue';
import BillDetail from './views/BillDetail.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/client_dashboard',
      name: 'dashboard',
      component: DashboardInitial,
    },
    {
      path: '/bills/:id',
      name: 'bill',
      component: BillDetail,
      props: true,
    },
  ],
});
