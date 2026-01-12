class ArchiveRoutineTool < RubyLLM::Tool
  description "Soft deletes a routine by archiving it. The history is preserved."
  param :routine_id, type: "integer"

  def execute(routine_id:)
    user = Current.user
    routine = user.routines.active.find(routine_id)
    routine.archive!
    "Routine '#{routine.name}' has been archived."
  end
end
