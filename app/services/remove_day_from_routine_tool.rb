class RemoveDayFromRoutineTool < RubyLLM::Tool
  description "Removes an entire training day from a routine."
  param :routine_day_id, type: "integer"

  def execute(routine_day_id:)
    rd = RoutineDay.find(routine_day_id)
    day = rd.day_of_week
    rd.destroy!
    "Removed '#{day}' from the routine."
  end
end
