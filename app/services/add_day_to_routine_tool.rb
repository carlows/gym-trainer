class AddDayToRoutineTool < RubyLLM::Tool
  description "Adds a day of the week to an existing routine"
  param :routine_id, type: "integer"
  param :day_of_week, type: "string", desc: "monday, tuesday, wednesday, thursday, friday, saturday, sunday"

  def execute(routine_id:, day_of_week:)
    user = Current.user
    routine = user.routines.find(routine_id)
    routine.routine_days.find_or_create_by!(day_of_week: day_of_week.downcase)
    "Day '#{day_of_week}' added to routine '#{routine.name}'."
  end
end
