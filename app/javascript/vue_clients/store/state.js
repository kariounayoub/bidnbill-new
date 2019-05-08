const root = document.getElementById('app')


export default {
  client: JSON.parse(root.dataset.client),
  bills: {data: {data: [ {attributes: {id: null, category:  ' ', current_provider: ' '}}]}}, // This is formatted in a simiar way to how it comes in from the api
  activeBill: {attributes: {id: null, category: ' ', current_provider: ' '}}, // This is formatted in a similar way to how it comes in from the api

}
