<template>
  <div class="container">
    <form>
      <div class="mb-3">
        <label>Item Name</label><br>
        <input
          v-model="name"
          type="text">
        <br>
        <label>Quantity</label><br>
        <input
          v-model="quantity"
          type="text">
        <br><br>
        <div class="btn-group" role="group">
          <button
            type="button"
            class="btn btn-primary btn-sm"
            @click="addItem">
            Submit
          </button>
          <button
            type="button"
            class="btn btn-danger btn-sm"
            @click="goBack">
            Cancel
          </button>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      name: "",
      quantity: "1",
    };
  },
  props: ['containerID'],
  methods: {
    addItem() {
      const path = `http://localhost:3000/api/v1/containers/${this.containerID}/items`;
      const payload = {
        name: this.name,
        quantity: this.quantity,
      };
      axios.post(path, payload)
        .then((res) => {
          if(res.status === 201) {
            this.$emit('showContainerItems', true);
            this.$emit('showItemNewForm', false);
            this.$parent.handleMessage('Item created!');
            this.$parent.getItems();
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },
    goBack() {
      this.$emit('showContainerItems', true);
      this.$emit('showItemNewForm', false);
    },
  },
};
</script>
