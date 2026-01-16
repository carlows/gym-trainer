class CreateRoutineTool < RubyLLM::Tool
  description "Creates a new workout routine for the user"
  param :name, desc: "The name of the routine (e.g. Push/Pull/Legs)"

  def execute(name:)
    user = Current.user
    routine = user.routines.create!(name: name)
    {
      content: "Routine '#{name}' created with ID #{routine.id}.",
      metadata: { type: "routine_created", ids: [ routine.id ] }
    }
  end
end
