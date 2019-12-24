import sharedMutations from "../../shared_store/mutations";

export default {
  TOOGLE_SIDEBAR_STATE: (state, payload) => {
    state.offset = !state.offset;
  },
  HIDE_SIDEBAR: state => {
    state.offset = true;
  },
  SET_BILLS: (state, payload) => {
    state.bills = payload;
    state.myBills = state.bills.data.data.filter(b => {
      if (checkBidUser(b, state.provider.data.attributes.id) > 0) return b;
    });
    state.accountBills = state.bills.data.data.filter(b => {
      if (checkBidAccount(b, state.provider.data.attributes.account.id) > 0)
        return b;
    });
  },
  SET_LOST_BILLS: (state, payload) => {
    state.lostBills = payload;
  },
  SET_MY_CLIENTS: (state, payload) => {
    state.myClients = payload;
  },
  SET_ACTIVE_CLIENT: (state, payload) => {
    state.activeClient = state.myClients.data.filter(
      c => c.bill.data.id === payload
    )[0];
  },
  UPDATE_PROVDIER: (state, payload) => {
    state.provider = payload;
  },
  SET_NEW_USER: (state, payload) => {
    state.account.data.attributes.account_users = [
      ...state.account.data.attributes.account_users,
      payload.data.user
    ];
  },
  REMOVE_USER: (state, payload) => {
    state.account.data.attributes.account_users = state.account.data.attributes.account_users.filter(
      u => u.data.id !== payload.data.id
    );
  },
  UPDATE_ACCOUNT: (state, payload) => {
    state.account = payload;
  },
  ...sharedMutations
};

function checkBidAccount(bill, account) {
  if (Array.isArray(bill.attributes.bids) && bill.attributes.bids.length > 0) {
    return bill.attributes.bids.filter(bid => {
      if (bid.account.id === account) return true;
    }).length;
  }
}

function checkBidUser(bill, user) {
  if (Array.isArray(bill.attributes.bids) && bill.attributes.bids.length > 0) {
    return bill.attributes.bids.filter(bid => {
      if (bid.account.user === user) return true;
    }).length;
  }
}
