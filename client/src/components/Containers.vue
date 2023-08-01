<template>
  <div class="container">
    <containerNewForm
      v-if="showContainerNewForm"
      @showContainerNewForm="showContainerNewForm = $event"
      @showContainerList="showContainerList = $event">
    </containerNewForm>
  </div>
  <div class="container">
    <containerEditForm
      :containerForEdit="containerForEdit"
      v-if="showContainerEditForm"
      @showContainerEditForm="showContainerEditForm = $event"
      @showContainerList="showContainerList = $event">
    </containerEditForm>
  </div>
  <div class="container" v-if="showContainerList && loaded">
    <div class="row">
      <div class="col-sm-10">
        <h1>Containers</h1>
        <br>
        <alert :message=message v-if="showMessage"></alert>
        <button
          type="button"
          class="btn btn-success"
          @click="handleNewButton">
          New Container
        </button>
        <table class="table table-hover">
          <thead>
            <tr>
              <th scope="col">Name</th>
              <th scope="col"># Items</th>
              <th></th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="container in containers">
              <td>{{ container.attributes.name }}</td>
              <td>{{ container.attributes.items.length }}</td>
              <td>
                <div class="btn-group" role="group">
                  <button
                    type="button"
                    class="btn btn-primary btn-sm"
                    @click="handleViewButton(container.id)">
                    View Items
                  </button>
                </div>
              </td>
              <td>
                <div class="btn-group" role="group">
                  <button
                    type="button"
                    class="btn btn-warning btn-sm"
                    @click="handleEditButton(container)">
                    Edit
                  </button>
                  <button
                    type="button"
                    class="btn btn-danger btn-sm"
                    @click="handleDeleteButton(container.id)">
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
import ContainerNewForm from './ContainerNewForm.vue';
import ContainerEditForm from './ContainerEditForm.vue';

export default {
  data() {
    return {
      containers: [],
      showContainerNewForm: false,
      showContainerEditForm: false,
      containerForEdit: null,
      showContainerList: true,
      message: '',
      showMessage: false,
      loaded: false,
    };
  },
  components: {
    alert: Alert,
    containerNewForm: ContainerNewForm,
    containerEditForm: ContainerEditForm,
  },
  methods: {
    getContainers() {
      const path = 'https://pure-reef-34935-cb295cd6a41d.herokuapp.com/api/v1/containers';
      axios.get(path)
        .then((res) => {
          this.containers = res.data.data;
          console.log(this.containers);
          this.loaded = true;
        })
        .catch((error) => {
          console.error(error);
        });
    },
    handleNewButton() {
      this.showContainerNewForm = true;
      this.showContainerList = false;
    },
    handleMessage(message) {
      this.showMessage = true;
      this.message = message;
      setTimeout(() => {
        this.showMessage = false;
      }, 5000);
    },
    handleViewButton(containerID) {
      this.$router.push({name: 'ContainerItems', params: {containerID: containerID}});
    },
    handleDeleteButton(containerID) {
      this.removeContainer(containerID);
    },
    removeContainer(containerID) {
      const path = `https://pure-reef-34935-cb295cd6a41d.herokuapp.com/api/v1/containers/${containerID}`;
      axios.delete(path)
        .then(() => {
          this.getContainers();
          this.handleMessage('Container deleted');
        })
        .catch((error) => {
          console.error(error);
          this.getContainers();
        });
    },
    handleEditButton(container) {
      this.showContainerEditForm = true;
      this.showContainerList = false;
      this.showContainerNewForm = false;
      this.containerForEdit = container;
    },
  },
  created() {
    this.getContainers();
  },
};
</script>
