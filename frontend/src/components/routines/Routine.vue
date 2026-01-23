<script setup lang="ts">
import { computed } from 'vue'
import { Card, CardHeader, CardTitle, CardContent, CardFooter } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import type { Routine } from '@/types/routine'
import { Dumbbell, Calendar, ChevronDown } from 'lucide-vue-next'
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from '@/components/ui/collapsible'

defineProps<{
  routine: Routine
}>()

const capitalize = (s: string) => s.charAt(0).toUpperCase() + s.slice(1)

const currentDay = computed(() => {
  return new Intl.DateTimeFormat('en-US', { weekday: 'long' }).format(new Date()).toLowerCase()
})
</script>

<template>
  <Card class="flex flex-col h-full">
    <CardHeader>
      <CardTitle>{{ routine.name }}</CardTitle>
    </CardHeader>
    <CardContent class="flex-1 overflow-y-auto space-y-2">
      <div v-for="day in routine.routine_days" :key="day.id">
        <Collapsible :default-open="day.day_of_week === currentDay" class="group">
          <CollapsibleTrigger class="flex items-center justify-between w-full p-2 rounded-lg hover:bg-muted/50 transition-colors">
            <div class="flex items-center gap-2 font-semibold text-sm text-muted-foreground">
              <Calendar class="h-4 w-4" />
              {{ capitalize(day.day_of_week) }}
              <span v-if="day.day_of_week === currentDay" class="text-[10px] bg-primary/10 text-primary px-1.5 py-0.5 rounded-full font-bold uppercase">
                Today
              </span>
            </div>
            <ChevronDown class="h-4 w-4 text-muted-foreground transition-transform duration-200 group-data-[state=open]:rotate-180" />
          </CollapsibleTrigger>

          <CollapsibleContent class="space-y-3 pt-2 px-2">
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
            <p v-else class="text-xs text-muted-foreground italic py-2">
              No exercises planned for this day.
            </p>
          </CollapsibleContent>
        </Collapsible>
      </div>
    </CardContent>
    <CardFooter class="border-t pt-6">
      <Button class="w-full">
        Start workout
      </Button>
    </CardFooter>
  </Card>
</template>
