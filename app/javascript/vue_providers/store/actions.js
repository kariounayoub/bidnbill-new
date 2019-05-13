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
}
