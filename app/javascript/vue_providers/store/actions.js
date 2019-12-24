import sharedActions from "../../shared_store/actions";
import userActions from "./actions/user_actions";
import biddingActions from "./actions/bidding_actions";

const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes
  .content.value;
export const config = {
  headers: {
    Accept: "application/json",
    "Content-Type": "application/json",
    "X-CSRF-Token": csrfToken
  },
  credentials: "same-origin"
};

export default {
  ...biddingActions,
  ...userActions,
  ...sharedActions
};
