import { createRouter, createWebHistory } from 'vue-router'
import DashboardView from '@/views/DashboardView.vue'
import { useAuth } from '@/composables/useAuth'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'dashboard',
      component: DashboardView,
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('@/views/LoginView.vue'),
    },
    {
      path: '/chat',
      name: 'chat',
      component: () => import('@/views/ChatView.vue'),
    },
  ],
})

router.beforeEach((to) => {
  const { isAuthenticated } = useAuth()

  if (!isAuthenticated.value && to.name !== 'login') {
    return { name: 'login' }
  }

  if (isAuthenticated.value && to.name === 'login') {
    return { name: 'dashboard' }
  }
})

export default router
