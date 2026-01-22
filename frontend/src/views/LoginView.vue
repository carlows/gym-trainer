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
      <p>"It never gets easier, you just get stronger"</p>
    </div>
    <div class="flex justify-center items-center flex-1 bg-background p-10">
      <div class="w-sm flex flex-col gap-4 text-center">
        <h2 class="font-bold text-xl">Login</h2>
        <p class="text-muted-foreground text-sm">Enter your identifier to start</p>
        <Input v-model="identifier" placeholder="Enter your id" />
        <Button size="sm" @click="handleLogin">Sign in with username</Button>
      </div>
    </div>
  </div>
</template>
