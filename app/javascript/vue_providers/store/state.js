const root = document.getElementById("app");

export default {
  flash: null,
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
        info: ""
      }
    ]
  },
  activeClient: null,
  mapKey: root.dataset.map
};
