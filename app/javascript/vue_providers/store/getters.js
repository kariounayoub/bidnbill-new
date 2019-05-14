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
  },
  OtherBills: state => {
    return state.bills.data.data.filter((b) => {
      if (!state.myBills.includes(b)) return b
    })
  },
  MyBills: state => {
    return state.myBills
  },
  MyClients: state => {
    return state.myClients.data
  },
  ActiveClient: state => {
    return state.activeClient
  }
}


