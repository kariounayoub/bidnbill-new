export default {
  Client: state => {
      return state.client.data
    },
  Bills: state => {
      return state.bills.data.data
    },
  ActiveBill: state => {
      return state.activeBill
    },

}
