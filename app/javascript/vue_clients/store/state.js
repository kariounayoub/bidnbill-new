const root = document.getElementById("app");

export default {
  client: JSON.parse(root.dataset.client),
  categories: JSON.parse(root.dataset.categories),
  bills: {
    data: {
      data: [
        { attributes: { id: null, category: " ", current_provider: "EDF" } }
      ]
    }
  }, // This is formatted in a simiar way to how it comes in from the api
  activeBill: {
    attributes: { id: null, category: " ", current_provider: " " }
  }, // This is formatted in a similar way to how it comes in from the api
  flash: null,
  mapKey: root.dataset.map,
  isLoading: false
};
