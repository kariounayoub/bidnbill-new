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
  MyBills: state => {
    return state.bills.data.data.filter((b) => {
      if (checkBidAccount(b, state.provider.data.attributes.account.id) > 0) return b
    })
  }
}


function checkBidAccount(bill, account) {
 if(Array.isArray(bill.attributes.bids) && bill.attributes.bids.length > 0) {
   return bill.attributes.bids.filter((bid) => {
      if(bid.account.id === account) return true
    }).length
  }
}
