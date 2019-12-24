import axios from "axios"; // axios is an http library to make http requrests (can use default fetch api instead)
import router from "../router";
import sharedActions from "../../shared_store/actions";
const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes
  .content.value;
const config = {
  headers: {
    Accept: "application/json",
    "Content-Type": "application/json",
    "X-CSRF-Token": csrfToken
  },
  credentials: "same-origin"
};

export default {
  UPDATE_USER: async ({ state, commit }, payload) => {
    await axios
      .patch(
        `/api/v1/users/${state.client.data.attributes.id}`,
        payload,
        config
      )
      .then(res => {
        commit("TOGGLE_IS_LOADING");

        if (res.data.success) {
          commit("UPDATE_CLIENT", res.data.user);
          commit("SET_FLASH", {
            message: "Compte modifié avec succès",
            variant: "primary"
          });
          router.push("/client_dashboard");
          window.location.reload();
        } else {
          commit("SET_FLASH", {
            message: "Erreur le compte n'a pas été modifié",
            variant: "error"
          });
        }
      })
      .catch(err => commit("SET_FLASH", { message: err, variant: "error" }));
  },
  GET_BILLS: async ({ state, commit }) => {
    await axios
      .get(`/api/v1/users/${state.client.data.attributes.id}/my_bills`, config)
      .then(res => commit("SET_BILLS", res))
      .catch(err => console.log(err));
  },
  GET_BILL: async ({ state, commit }, payload) => {
    await axios
      .get(
        `/api/v1/users/${state.client.data.attributes.id}/bills/${payload}`,
        config
      )
      .then(res => commit("SET_BILL", res))
      .catch(err => console.log(err));
  },
  CREATE_BILL: async ({ state, commit }, payload) => {
    await axios
      .post(
        `/api/v1/users/${state.client.data.attributes.id}/bills`,
        payload,
        config
      )
      .then(res => {
        router.push("/client_dashboard");
        if (res.data.success) {
          commit("ADD_BILL", res.data.bill.data);
          commit("SET_FLASH", {
            message: "Enchère enregistrée avec succès",
            variant: "primary"
          });
        } else {
          commit("SET_FLASH", {
            message: "Erreur l'Enchère n'a pas été enregistrée",
            variant: "error"
          });
        }
      })
      .catch(err => commit("SET_FLASH", { message: err, variant: "error" }));
  },
  UPDATE_BILL: async ({ state, commit }, payload) => {
    await axios
      .patch(
        `/api/v1/users/${state.client.data.attributes.id}/bills/${payload.bill_id}`,
        payload,
        config
      )
      .then(res => {
        if (res.data.success) {
          commit("UPDATE_BILL", res.data.bill.data);
          commit("SET_FLASH", {
            message: "Enchère modifiée avec succès",
            variant: "primary"
          });
        } else {
          commit("SET_FLASH", {
            message: "Erreur l'Enchère n'a pas été modifiée",
            variant: "error"
          });
        }
      })
      .catch(err => commit("SET_FLASH", { message: err, variant: "error" }));
  },
  SELECT_BID: async ({ state, commit }, payload) => {
    await axios
      .patch(`/api/v1/bids/${payload.id}/select`, payload, config)
      .then(res => {
        if (res.data.success) {
          commit("UPDATE_BILL", res.data.bill.data);
          commit("SET_FLASH", {
            message: "Enchère validée avec succès",
            variant: "primary"
          });
        } else {
          commit("SET_FLASH", {
            message: "Erreur la séléction n'a pas aboutie",
            variant: "error"
          });
        }
      })
      .catch(err => commit("SET_FLASH", { message: err, variant: "error" }));
  },
  ...sharedActions
};
