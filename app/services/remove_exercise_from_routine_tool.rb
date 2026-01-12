class RemoveExerciseFromRoutineTool < RubyLLM::Tool
  description "Removes an exercise from a routine day."
  param :routine_exercise_id, type: "integer"

  def execute(routine_exercise_id:)
    re = RoutineExercise.find(routine_exercise_id)
    name = re.exercise.name
    re.destroy!
    "Removed '#{name}' from the routine."
  end
end
