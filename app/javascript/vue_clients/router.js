import Vue from "vue";
import Router from "vue-router";
import DashboardInitial from "./views/DashboardInitial.vue";
import BillDetail from "./views/BillDetail.vue";
import BillForm from "./views/BillForm.vue";
import EditUser from "./views/EditUser.vue";

Vue.use(Router);

export default new Router({
  mode: "history",
  base: process.env.BASE_URL,
  routes: [
    {
      path: "/client_dashboard",
      name: "dashboard",
      component: DashboardInitial
    },
    {
      path: "/bills/new",
      name: "new_bill",
      component: BillForm
    },
    {
      path: "/bills/:id",
      name: "bill",
      component: BillDetail,
      props: true
    },
    {
      path: "/users/edit_client",
      name: "edit_client",
      component: EditUser
    }
  ],
  scrollBehavior() {
    return { x: 0, y: 0 };
  }
});
