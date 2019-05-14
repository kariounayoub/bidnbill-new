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
    await axios.get(`/api/v1/users/${state.provider.data.attributes.id}/bills`, config)
    .then(res => commit('SET_BILLS', res))
    .catch(err => console.log(err))
  },
  GET_MY_CLIENTS: async ({state, commit}) => {
    await axios.get(`/api/v1/users/${state.provider.data.attributes.id}/my_clients`, config)
    .then(res => commit('SET_MY_CLIENTS', res))
    .catch(err => console.log(err))
  },
  CREATE_BID: async ({state,commit,dispatch}, payload) => {
    await axios.post(`/api/v1/bids`, payload, config)
    .then((res) => {
      if(res.data.success) {
        dispatch('GET_BILLS');
        commit('SET_FLASH', { message: 'Enchère enregistré avec succès', variant: 'success' })
      } else {
        commit('SET_FLASH', {message: "Erreur l'enchère n'a pas été enregistré", variant: 'error'})
      }
    })
    .catch(err => commit('SET_FLASH', {message: err, variant: 'error'}))
  }
}
