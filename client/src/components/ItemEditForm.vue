<template>
  <div class="container">
    <form>
      <div class="mb-3">
        <label>Name</label><br>
        <input
          v-model="itemForEdit.name"
          type="text">
        <br>
        <label>Quantity</label><br>
        <input
          v-model="itemForEdit.quantity"
          type="text">
        <br><br>
        <div class="btn-group" role="group">
          <button
            type="button"
            class="btn btn-primary btn-sm"
            @click="editItem">
            Save
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
  props: ['containerID', 'itemForEdit'],
  methods: {
    editItem() {
      const path = `https://pure-reef-34935-cb295cd6a41d.herokuapp.com/api/v1/containers/${this.containerID}/items/${this.itemForEdit.id}`;
      const payload = {
        name: this.itemForEdit.name,
        quantity: this.itemForEdit.quantity,
      };
      axios.patch(path, payload)
        .then((res) => {
          if(res.status === 200) {
            this.$emit('showContainerItems', true);
            this.$emit('showItemEditForm', false);
            this.$parent.handleMessage('Item updated');
            this.$parent.getItems();
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },
    goBack() {
      this.$emit('showContainerItems', true);
      this.$emit('showItemEditForm', false);
    },
  },
};
</script>
