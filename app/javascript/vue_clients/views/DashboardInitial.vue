<template>
  <div>
    {{message}}
    {{id}}
    <p>
      {{bills}}
    </p>
  </div>
</template>

<script>
import axios from 'axios' // axios is an http library to make http requrests (can use default fetch api instead)
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
  const root = document.getElementById('app')

  export default {
    name: 'DashboardInitial',
    data: () => ({
      message: 'Hello Client',
      id: JSON.parse(root.dataset.id),
      bills: null
    }),
    methods: {
      GET_BILLS() {
        axios.get(`/api/v1/users/${this.id}/bills`)
        .then(res => this.bills = res)
      }
    },
    mounted() {
      this.GET_BILLS();
    }
  }
</script>
