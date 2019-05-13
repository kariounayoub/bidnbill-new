const root = document.getElementById('app')


export default {
  client: JSON.parse(root.dataset.client),
  categories: JSON.parse(root.dataset.categories),
  bills: {data:  [{bill: {data: {attributes: {id: null, category:  ' ', current_provider: 'EDF'}}}, info: ''}]}, // This is formatted in a simiar way to how it comes in from the api
  activeBill: {bill: {data: {attributes: {id: null, category:  ' ', current_provider: 'EDF'}}}, info: ''}, // This is formatted in a similar way to how it comes in from the api
  flash: null,


}
