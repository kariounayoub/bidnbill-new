export default {
  TOOGLE_SIDEBAR_STATE: (state, payload) => {
    state.offset = !state.offset;
  },
  SET_FLASH: (state, payload) => {
    state.flash = payload;
  },
  SET_BILLS: (state, payload) => {
    state.bills = payload;
    state.myBills =  state.bills.data.data.filter((b) => {
      if (checkBidAccount(b, state.provider.data.attributes.account.id) > 0) return b
    });
  },
  SET_MY_CLIENTS: (state, payload) => {
    state.myClients = payload;
  },
  SET_ACTIVE_CLIENT: (state, payload) => {
    state.activeClient = state.myClients.data.filter(c => c.bill.data.id === payload)[0]
  }
}


function checkBidAccount(bill, account) {
 if(Array.isArray(bill.attributes.bids) && bill.attributes.bids.length > 0) {
   return bill.attributes.bids.filter((bid) => {
      if(bid.account.id === account) return true
    }).length
  }
}
