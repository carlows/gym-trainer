class UpdateRoutineExerciseTool < RubyLLM::Tool
  description "Updates target sets and reps for a specific exercise in a routine."
  param :routine_exercise_id, type: "integer"
  param :target_sets, type: "integer"
  param :target_reps, type: "integer"

  def execute(routine_exercise_id:, target_sets:, target_reps:)
    re = RoutineExercise.find(routine_exercise_id)
    re.update!(target_sets: target_sets, target_reps: target_reps)
    "Updated #{re.exercise.name} to #{target_sets} sets of #{target_reps} reps."
  end
end
