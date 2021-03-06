import axios from "axios"; // axios is an http library to make http requrests (can use default fetch api instead)
import router from "../../router";
import { config } from "../actions";

export default {
  GET_BILLS: async ({ state, commit }) => {
    await axios
      .get(`/api/v1/users/${state.provider.data.attributes.id}/bills`, config)
      .then(res => commit("SET_BILLS", res))
      .catch(err => console.log(err));
  },
  GET_LOST_BILLS: async ({ state, commit }) => {
    await axios
      .get(
        `/api/v1/users/${state.provider.data.attributes.id}/lost_bills`,
        config
      )
      .then(res => commit("SET_LOST_BILLS", res))
      .catch(err => console.log(err));
  },
  GET_MY_CLIENTS: async ({ state, commit }) => {
    await axios
      .get(
        `/api/v1/users/${state.provider.data.attributes.id}/my_clients`,
        config
      )
      .then(res => commit("SET_MY_CLIENTS", res))
      .catch(err => console.log(err));
  },
  CREATE_BID: async ({ state, commit, dispatch }, payload) => {
    await axios
      .post(`/api/v1/bids`, payload, config)
      .then(res => {
        if (res.data.success) {
          dispatch("GET_BILLS");
          commit("SET_FLASH", {
            message: "Enchère enregistrée avec succès",
            variant: "primary"
          });
        } else {
          commit("SET_FLASH", {
            message: "Erreur l'enchère n'a pas été enregistrée",
            variant: "error"
          });
        }
      })
      .catch(err => commit("SET_FLASH", { message: err, variant: "error" }));
  },
  UPDATE_BID: async ({ state, commit, dispatch }, payload) => {
    await axios
      .patch(`/api/v1/bids/${payload.bid_id}`, payload, config)
      .then(res => {
        if (res.data.success) {
          dispatch("GET_BILLS");
          commit("SET_FLASH", {
            message: "Enchère modifiée avec succès",
            variant: "primary"
          });
        } else {
          commit("SET_FLASH", {
            message: "Erreur l'enchère n'a pas été modifiée",
            variant: "error"
          });
        }
      })
      .catch(err => commit("SET_FLASH", { message: err, variant: "error" }));
  }
};
