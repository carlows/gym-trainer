export interface Exercise {
  id: number
  name: string
  description: string
  exercise_type: string
  body_part: string
  equipment: string
  created_at: string
  updated_at: string
}

export interface RoutineExercise {
  id: number
  routine_day_id: number
  exercise_id: number
  target_sets: number
  target_reps: number
  created_at: string
  updated_at: string
  exercise: Exercise
}

export interface RoutineDay {
  id: number
  routine_id: number
  day_of_week: string
  created_at: string
  updated_at: string
  routine_exercises: RoutineExercise[]
}

export interface Routine {
  id: number
  user_id: number
  name: string
  created_at: string
  updated_at: string
  archived: boolean | null
  archived_at: string | null
  routine_days: RoutineDay[]
}
