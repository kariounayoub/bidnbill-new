export default {
  SET_BILLS: (state, payload) => {
    state.bills = payload;
  },
  SET_ACTIVE_BILL:(state, payload) => {
    state.activeBill = state.bills.data.data.filter(b => b.id === payload)[0]
  },
  SET_BILL:(state, payload) => {
    state.activeBill = payload.data.data
  }
}
