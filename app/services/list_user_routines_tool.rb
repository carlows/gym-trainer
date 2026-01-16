class ListUserRoutinesTool < RubyLLM::Tool
  description "Lists all active routines with their days and exercises. Useful for finding IDs to edit."

  def execute
    user = Current.user
    routines = user.routines.active.includes(routine_days: { routine_exercises: :exercise })

    if routines.empty?
      return "You have no active routines."
    end

    content = routines.map do |r|
      days_info = r.routine_days.map do |rd|
        ex_info = rd.routine_exercises.map do |re|
          "- [RE_ID: #{re.id}] #{re.exercise.name}: #{re.target_sets}x#{re.target_reps} (EX_ID: #{re.exercise_id})"
        end.join("\n      ")
        "  #{rd.day_of_week.capitalize} (RD_ID: #{rd.id}):\n      #{ex_info.presence || "No exercises"}"
      end.join("\n")
      "Routine: #{r.name} (ID: #{r.id})\n#{days_info}"
    end.join("\n\n")

    {
      content: content,
      metadata: { type: "routine_list", ids: routines.pluck(:id) }
    }
  end
end
