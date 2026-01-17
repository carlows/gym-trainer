<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuth } from '@/composables/useAuth'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'

const identifier = ref('')
const router = useRouter()
const { login } = useAuth()
const handleLogin = () => {
  if (identifier.value.trim()) {
    login(identifier.value)
    router.push('/') // Redirect to dashboard
  }
}
</script>

<template>
  <div class="flex flex-row h-screen">
    <div class="flex flex-col justify-between flex-1 bg-secondary p-10">
      <h2 class="text-lg font-semibold tracking-tight">Gym Trainer</h2>
      <p>"No pain no gain."</p>
    </div>
    <div class="flex flex-col justify-center items-center flex-1 bg-background">
      <div class="max-w-lg">
        <h2 class="font-bold text-xl">Login</h2>
        <p class="text-secondary-foreground">Enter your identifier to start</p>
        <Input v-model="identifier" placeholder="Enter your id" />
        <Button size="sm" @click="handleLogin">Login</Button>
      </div>
    </div>
  </div>
</template>
