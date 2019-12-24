import axios from "axios"; // axios is an http library to make http requrests (can use default fetch api instead)
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
  SEEN_NOTIFICATIONS: async ({}, payload) => {
    await axios.patch(`/api/v1/notifications/${payload}/seen`, config);
  },
  SIGN_OUT: async ({}, payload) => {
    axios
      .delete(`${window.location.origin}/users/sign_out`, config)
      .then(res => window.location.assign(window.location.origin));
  }
};
