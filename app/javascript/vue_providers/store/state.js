const root = document.getElementById('app')


export default {
  flash: null,
  offset: false,
  provider: JSON.parse(root.dataset.provider),
  bills: {data: {data: [ {attributes: {id: null, category:  ' ', current_provider: 'EDF'}}]}}, // This is formatted in a simiar way to how it comes in from the api
  myBills: [],
  accountBills: [],
  myClients: {data: [{bill: {data: {id: null, attributes: { category: ''}}}, client: {data: {attributes: ''}}, info: ''}]},
  activeClient : null,
  mapKey: root.dataset.map
}
