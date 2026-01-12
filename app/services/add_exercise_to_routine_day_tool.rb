class AddExerciseToRoutineDayTool < RubyLLM::Tool
  description "Adds an exercise to a specific routine day with target sets and reps"
  param :routine_id, type: "integer"
  param :day_of_week, type: "string", desc: "monday, tuesday, wednesday, thursday, friday, saturday, sunday"
  param :exercise_id, type: "integer"
  param :target_sets, type: "integer"
  param :target_reps, type: "integer"

  def execute(routine_id:, day_of_week:, exercise_id:, target_sets:, target_reps:)
    user = Current.user
    routine = user.routines.find(routine_id)
    day = routine.routine_days.find_or_create_by!(day_of_week: day_of_week.downcase)
    exercise = Exercise.find(exercise_id)

    day.routine_exercises.create!(
      exercise: exercise,
      target_sets: target_sets,
      target_reps: target_reps
    )

    "Added #{exercise.name} to #{routine.name} on #{day_of_week} (#{target_sets} sets of #{target_reps} reps)."
  end
end
