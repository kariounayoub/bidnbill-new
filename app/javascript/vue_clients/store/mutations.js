export default {
  SET_BILLS: (state, payload) => {
    state.bills = payload;
  },
  SET_ACTIVE_BILL: (state, payload) => {
    state.activeBill = state.bills.data.filter(b => b.bill.data.id === payload)[0]
  },
  SET_BILL: (state, payload) => {
    state.activeBill = payload.data
  },
  SET_FLASH: (state, payload) => {
    state.flash = payload;
  },
  ADD_BILL: (state,payload) => {
    state.bills.data.push(payload)
  },
  UPDATE_CLIENT: (state,payload) => {
    state.client = payload
  }
}
