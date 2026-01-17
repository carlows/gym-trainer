<script setup lang="ts">
import { Button } from '@/components/ui/button'
</script>

<template>
  <header class="h-16 border-b flex items-center px-6 md:px-8 justify-between">
    <div class="md:hidden font-bold">Gym Trainer</div>
    <div class="flex items-center gap-4 ml-auto">
      <Button variant="outline" size="sm">Profile</Button>
    </div>
  </header>
</template>
