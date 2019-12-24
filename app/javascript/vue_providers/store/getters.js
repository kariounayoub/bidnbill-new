import sharedGetters from "../../shared_store/getters";

export default {
  Provider: state => {
    return state.provider.data;
  },
  Account: state => {
    return state.account.data;
  },
  Offset: state => {
    return state.offset;
  },
  Bills: state => {
    return state.bills.data.data;
  },
  OtherBills: state => {
    return state.bills.data.data.filter(b => {
      if (!state.accountBills.includes(b)) return b;
    });
  },
  MyBills: state => {
    return state.myBills;
  },
  AccountBills: state => {
    return state.accountBills;
  },
  MyClients: state => {
    return state.myClients.data;
  },
  ActiveClient: state => {
    return state.activeClient;
  },
  LostBills: state => {
    return state.lostBills.data.data;
  },
  ...sharedGetters
};
