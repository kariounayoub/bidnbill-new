const root = document.getElementById("app");
import sharedState from "../../shared_store/state";

export default {
  offset: false,
  provider: JSON.parse(root.dataset.provider),
  account: JSON.parse(root.dataset.account),
  bills: {
    data: {
      data: [{ attributes: { id: null, category: " ", current_provider: "" } }]
    }
  }, // This is formatted in a simiar way to how it comes in from the api
  lostBills: {
    data: {
      data: [{ attributes: { id: null, category: " ", current_provider: "" } }]
    }
  }, // This is formatted in a simiar way to how it comes in from the api
  myBills: [],
  accountBills: [],
  myClients: {
    data: [
      {
        bill: { data: { id: null, attributes: { category: "" } } },
        client: { data: { attributes: "" } },
        bid: { data: { id: null, attributes: {} } }
      }
    ]
  },
  activeClient: null,
  ...sharedState
};
