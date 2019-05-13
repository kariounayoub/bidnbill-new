export default {
  Flash: state => {
      return state.flash
    },
  Provider: state => {
      return state.provider.data
    },
  Offset: state => {
      return state.offset
    },
  Bills: state => {
    return state.bills.data.data
  }
}
