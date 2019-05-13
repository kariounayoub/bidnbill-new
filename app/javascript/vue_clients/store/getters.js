export default {
  Flash: state => {
      return state.flash
    },
  Client: state => {
      return state.client.data
    },
  Categories: state => {
      return state.categories
    },
  Bills: state => {
      return state.bills.data
    },
  ActiveBill: state => {
      return state.activeBill
    },

}
