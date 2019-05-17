export default {
  SET_BILLS: (state, payload) => {
    state.bills = payload;
  },
  SET_ACTIVE_BILL: (state, payload) => {
    state.activeBill = state.bills.data.data.filter(b => b.id === payload)[0]
  },
  SET_BILL: (state, payload) => {
    state.activeBill = payload.data.data
  },
  SET_FLASH: (state, payload) => {
    state.flash = payload;
  },
  ADD_BILL: (state,payload) => {
    state.bills.data.data.push(payload)
  },
  UPDATE_CLIENT: (state,payload) => {
    state.client = payload
  },
  UPDATE_BILL: (state,payload) => {
    state.activeBill = payload
    const index = state.bills.data.data.map(b=> b.id).indexOf(payload.id);
    state.bills.data.data[index] = payload
  }
}
