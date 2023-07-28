<template>
  <div class="container">
    <form>
      <div class="mb-3">
        <label>Name</label><br>
        <input
          v-model="containerForEdit.attributes.name"
          type="text">
        <br><br>
        <div class="btn-group" role="group">
          <button
            type="button"
            class="btn btn-primary btn-sm"
            @click="editContainer">
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
  props: ['containerForEdit'],
  methods: {
    editContainer() {
      const path = `http://localhost:3000/api/v1/containers/${this.containerForEdit.id}`;
      const payload = {
        name: this.containerForEdit.attributes.name,
      };
      axios.patch(path, payload)
        .then((res) => {
          if(res.status === 200) {
            this.$emit('showContainerList', true);
            this.$emit('showContainerEditForm', false);
            this.$parent.handleMessage('Container updated');
            this.$parent.getContainers();
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },
    goBack() {
      this.$emit('showContainerList', true);
      this.$emit('showContainerEditForm', false);
    },
  },
};
</script>
