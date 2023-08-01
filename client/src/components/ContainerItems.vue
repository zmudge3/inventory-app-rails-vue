<template>
  <div class="container">
    <itemNewForm
      :containerID=containerID
      v-if="showItemNewForm"
      @showItemNewForm="showItemNewForm = $event"
      @showContainerItems="showContainerItems = $event">
    </itemNewForm>
  </div>
  <div class="container">
    <itemEditForm
      :containerID="containerID"
      :itemForEdit="itemForEdit"
      v-if="showItemEditForm"
      @showItemEditForm="showItemEditForm = $event"
      @showContainerItems="showContainerItems = $event">
    </itemEditForm>
  </div>
  <div class="container" v-if="showContainerItems && loaded">
    <button
      type="button"
      class="btn btn-outline-primary"
      @click="handleBackButton">
      <i class="fa-solid fa-arrow-left"></i> Back
    </button>
    <br><br>
    <div class="row">
      <div class="col-sm-10">
        <h2>{{ name }}: Items</h2>
        <br>
        <alert :message=message v-if="showMessage"></alert>
        <button
          type="button"
          class="btn btn-success"
          @click="handleNewButton">
          New Item
        </button>
        <table class="table table-hover">
          <thead>
            <tr>
              <th scope="col">Name</th>
              <th scope="col">Quantity</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="item in items">
              <td>{{ item.name }}</td>
              <td>{{ item.quantity }}</td>
              <td>
                <div class="btn-group" role="group">
                  <button
                    type="button"
                    class="btn btn-warning btn-sm"
                    @click="handleEditButton(item)">
                    Edit
                  </button>
                  <button
                    type="button"
                    class="btn btn-danger btn-sm"
                    @click="handleDeleteButton(item)">
                    Delete
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Alert from './Alert.vue';
import ItemNewForm from './ItemNewForm.vue';
import ItemEditForm from './ItemEditForm.vue'

export default {
  data() {
    return {
      name: '',
      items: [],
      containerID: null,
      itemForEdit: null,
      showContainerItems: true,
      showItemNewForm: false,
      showItemEditForm: false,
      message: '',
      showMessage: false,
      loaded: false,
    };
  },
  components: {
    alert: Alert,
    itemNewForm: ItemNewForm,
    itemEditForm: ItemEditForm,
  },
  methods: {
    getItems() {
      const path = `https://pure-reef-34935-cb295cd6a41d.herokuapp.com/api/v1/containers/${this.containerID}`;
      axios.get(path)
        .then((res) => {
          this.name = res.data.data.attributes.name;
          this.items = res.data.data.attributes.items;
          this.loaded = true;
        })
        .catch((error) => {
          console.error(error);
        });
    },
    handleNewButton() {
      this.showItemNewForm = true;
      this.showContainerItems = false;
      this.showItemEditForm = false;
    },
    handleMessage(message) {
      this.showMessage = true;
      this.message = message;
      setTimeout(() => {
        this.showMessage = false;
      }, 5000);
    },
    handleBackButton() {
      this.$router.go(-1);
    },
    handleDeleteButton(item) {
      this.removeItem(item.id);
    },
    removeItem(itemID) {
      const path = `https://pure-reef-34935-cb295cd6a41d.herokuapp.com/api/v1/containers/${this.containerID}/items/${itemID}`;
      axios.delete(path)
        .then(() => {
          this.getItems();
          this.handleMessage('Item deleted');
        })
        .catch((error) => {
          console.error(error);
          this.getItems();
        });
    },
    handleEditButton(item) {
      this.showItemEditForm = true;
      this.showContainerItems = false;
      this.showItemNewForm = false;
      this.itemForEdit = item;
    },
  },
  created() {
    this.containerID = this.$route.params.containerID;
    this.getItems();
  },
};
</script>
