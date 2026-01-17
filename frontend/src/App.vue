<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
import { Header } from '@/components/layout'
import { Button } from '@/components/ui/button'
import { LayoutDashboard, MessageSquare } from 'lucide-vue-next'
import { useAuth } from '@/composables/useAuth'

const { isAuthenticated } = useAuth()
</script>

<template>
  <div class="flex min-h-screen bg-background">
    <aside v-if="isAuthenticated" class="w-64 border-r bg-card hidden md:flex flex-col">
      <div class="p-6">
        <h2 class="text-lg font-semibold tracking-tight">Gym Trainer</h2>
      </div>
      <nav class="flex-1 px-4 space-y-2">
        <RouterLink to="/" v-slot="{ isActive }">
          <Button 
            variant="ghost" 
            class="w-full justify-start gap-2" 
            :class="{ 'bg-muted': isActive }"
          >
            <LayoutDashboard class="h-4 w-4" />
            Dashboard
          </Button>
        </RouterLink>
        <RouterLink to="/chat" v-slot="{ isActive }">
          <Button 
            variant="ghost" 
            class="w-full justify-start gap-2" 
            :class="{ 'bg-muted': isActive }"
          >
            <MessageSquare class="h-4 w-4" />
            Chat
          </Button>
        </RouterLink>
      </nav>
    </aside>

    <!-- Main Content -->
    <div class="flex-1 flex flex-col">
      <Header v-if="isAuthenticated" />
      
      <main class="flex-1 overflow-y-auto">
        <RouterView />
      </main>
    </div>
  </div>
</template>

<style>
/* Global resets are handled by style.css */
</style>
