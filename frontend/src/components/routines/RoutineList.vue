<script setup lang="ts">
import { useQuery } from '@tanstack/vue-query'
import Routine from './Routine.vue'
import type { Routine as RoutineType } from '@/types/routine'
import { Loader2 } from 'lucide-vue-next'

const fetchRoutines = async (): Promise<RoutineType[]> => {
  const response = await fetch('http://localhost:3000/api/v1/routines')
  if (!response.ok) {
    throw new Error('Network response was not ok')
  }
  return response.json()
}

const { data: routines, isLoading, isError, error } = useQuery({
  queryKey: ['routines'],
  queryFn: fetchRoutines,
})
</script>

<template>
  <div>
    <div v-if="isLoading" class="flex flex-col items-center justify-center py-12 space-y-4">
      <Loader2 class="h-8 w-8 animate-spin text-muted-foreground" />
      <p class="text-sm text-muted-foreground">Loading your routines...</p>
    </div>

    <div v-else-if="isError" class="p-4 border border-destructive/50 rounded-lg bg-destructive/10 text-destructive text-sm">
      Failed to load routines: {{ error instanceof Error ? error.message : 'Unknown error' }}
    </div>

    <div v-else-if="routines && routines.length > 0" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <Routine v-for="routine in routines" :key="routine.id" :routine="routine" />
    </div>

    <div v-else class="text-center py-12 border-2 border-dashed rounded-xl">
      <p class="text-muted-foreground">You don't have any routines yet.</p>
    </div>
  </div>
</template>
