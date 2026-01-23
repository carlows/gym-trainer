<script setup lang="ts">
import RoutineList from '@/components/routines/RoutineList.vue'
</script>

<template>
  <div class="space-y-6 p-8">
    <div class="flex items-center justify-between">
      <h1 class="text-xl font-bold tracking-tight">Active Routines</h1>
    </div>

    <RoutineList />
  </div>
</template>
