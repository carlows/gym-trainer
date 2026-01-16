<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
import { Button } from '@/components/ui/button'
import { LayoutDashboard, MessageSquare } from 'lucide-vue-next'
</script>

<template>
  <div class="flex min-h-screen bg-background">
    <!-- Sidebar -->
    <aside class="w-64 border-r bg-card hidden md:flex flex-col">
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
      <div class="p-4 border-t">
        <p class="text-xs text-muted-foreground text-center">Modern Vue SPA</p>
      </div>
    </aside>

    <!-- Main Content -->
    <div class="flex-1 flex flex-col">
      <!-- Top header (mobile/responsive) -->
      <header class="h-16 border-b flex items-center px-6 md:px-8 justify-between">
        <div class="md:hidden font-bold">Gym Trainer</div>
        <div class="flex items-center gap-4 ml-auto">
          <Button variant="outline" size="sm">Profile</Button>
        </div>
      </header>
      
      <main class="flex-1 p-6 md:p-8 overflow-y-auto">
        <RouterView />
      </main>
    </div>
  </div>
</template>

<style>
/* Global resets are handled by style.css */
</style>
