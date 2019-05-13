import axios from 'axios' // axios is an http library to make http requrests (can use default fetch api instead)
import router from '../router'
const ROOT_URL = `${window.location.origin}`;
const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;
const config = {
   headers: {
        Accept: 'application/json',
      'Content-Type': 'application/json',
       'X-CSRF-Token': csrfToken
      },
    credentials: "same-origin"
}

export default {
  GET_BILLS: async ({state, commit}) => {
    await axios.get(`/api/v1/users/${state.client.data.attributes.id}/my_bills`, config)
    .then(res => commit('SET_BILLS', res))
    .catch(err => console.log(err))
  },
  GET_BILL: async ({state, commit}, payload) => {
    await axios.get(`/api/v1/users/${state.client.data.attributes.id}/bills/${payload}`, config)
    .then(res => commit('SET_BILL', res))
    .catch(err => console.log(err))
  },
  CREATE_BILL: async ({state,commit}, payload) => {
    await axios.post(`/api/v1/users/${state.client.data.attributes.id}/bills`, payload, config)
    .then((res) => {
      router.push('/client_dashboard');
      if(res.data.success) {
        commit('ADD_BILL', res.data.bill.data);
        commit('UPDATE_CLIENT', res.data.user)
        commit('SET_FLASH', { message: 'Abonnement enregistré avec succès', variant: 'success' })
      } else {
        commit('SET_FLASH', {message: "Erreur l'abonnement n'a pas été enregistré", variant: 'error'})
      }
    })
    .catch(err => commit('SET_FLASH', {message: err, variant: 'error'}))
  }
}
