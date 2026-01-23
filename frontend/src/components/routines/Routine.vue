<script setup lang="ts">
import { Card, CardHeader, CardTitle, CardContent, CardFooter } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import type { Routine } from '@/types/routine'
import { Dumbbell, Calendar } from 'lucide-vue-next'

defineProps<{
  routine: Routine
}>()

const capitalize = (s: string) => s.charAt(0).toUpperCase() + s.slice(1)
</script>

<template>
  <Card class="h-full">
    <CardHeader>
      <CardTitle>{{ routine.name }}</CardTitle>
    </CardHeader>
    <CardContent class="space-y-6">
      <div v-for="day in routine.routine_days" :key="day.id" class="space-y-2">
        <div class="flex items-center gap-2 font-semibold text-sm text-muted-foreground">
          <Calendar class="h-4 w-4" />
          {{ capitalize(day.day_of_week) }}
        </div>
        
        <div v-if="day.routine_exercises.length > 0" class="space-y-3">
          <div 
            v-for="re in day.routine_exercises" 
            :key="re.id"
            class="flex items-start gap-3 p-3 rounded-lg border bg-muted/50"
          >
            <div class="mt-1">
              <Dumbbell class="h-4 w-4 text-primary" />
            </div>
            <div class="flex-1 min-w-0">
              <p class="text-sm font-medium leading-none truncate">
                {{ re.exercise.name }}
              </p>
              <p class="text-xs text-muted-foreground mt-1">
                {{ re.target_sets }} sets × {{ re.target_reps }} reps
              </p>
            </div>
          </div>
        </div>
        <p v-else class="text-xs text-muted-foreground italic px-3">
          No exercises planned for this day.
        </p>
      </div>
    </CardContent>
    <CardFooter class="mt-auto">
      <Button class="w-full">
        Start workout
      </Button>
    </CardFooter>
  </Card>
</template>
