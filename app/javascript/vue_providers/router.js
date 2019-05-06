import Vue from 'vue';
import Router from 'vue-router';
import DashboardInitial from './views/DashboardInitial.vue';


Vue.use(Router);

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/:id/dashboard',
      name: 'dashboard',
      component: DashboardInitial,
    },
  ],
});
