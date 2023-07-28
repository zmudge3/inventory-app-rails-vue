import { createRouter, createWebHistory } from 'vue-router'
import Containers from '../components/Containers.vue'
import ContainerItems from '../components/ContainerItems.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'Containers',
      component: Containers,
    },
    {
      path: '/containers/:containerID',
      name: 'ContainerItems',
      component: ContainerItems,
    },
  ]
})

export default router
