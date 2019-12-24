export default {
  SET_FLASH: (state, payload) => {
    state.flash = payload;
  },
  TOGGLE_IS_LOADING: state => {
    state.isLoading = !state.isLoading;
  }
};
