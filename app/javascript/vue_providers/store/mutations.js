export default {
  TOOGLE_SIDEBAR_STATE: (state, payload) => {
    state.offset = !state.offset;
  },
  SET_BILLS: (state, payload) => {
    state.bills = payload;
  },
}
