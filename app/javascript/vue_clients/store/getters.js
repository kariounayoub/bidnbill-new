import sharedGetters from "../../shared_store/getters";

export default {
  Client: state => {
    return state.client.data;
  },
  Categories: state => {
    return state.categories;
  },
  Bills: state => {
    return state.bills.data.data;
  },
  ActiveBill: state => {
    return state.activeBill;
  },
  ...sharedGetters
};
