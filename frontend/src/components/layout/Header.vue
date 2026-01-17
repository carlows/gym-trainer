<script setup lang="ts">
import { useRouter } from 'vue-router'
import { Button } from '@/components/ui/button'
import { useAuth } from '@/composables/useAuth'

const router = useRouter()
const { logout, userIdentifier } = useAuth()
const handleLogout = () => {
  logout()
  router.push('/login')
}
</script>

<template>
  <header class="h-16 border-b flex items-center px-6 md:px-8 justify-between">
    <div class="md:hidden font-bold">Gym Trainer</div>
    <div class="flex items-center gap-4 ml-auto">
      <p>Hi, {{ userIdentifier }}</p>
      <Button variant="outline" size="sm" @click="handleLogout">Logout</Button>
    </div>
  </header>
</template>
