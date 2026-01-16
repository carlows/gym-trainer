class SearchExerciseTool < RubyLLM::Tool
  description "Searches for an exercise in the library by name"
  param :query, type: "string", desc: "The name or part of the name of the exercise"

  def execute(query:)
    exercises = Exercise.where("name LIKE ?", "%#{query}%").limit(5)

    if exercises.any?
      content = exercises.map { |e| "ID: #{e.id}, Name: #{e.name}, Body Part: #{e.body_part}" }.join("\n")
      {
        content: content,
        metadata: { type: "exercise_list", ids: exercises.pluck(:id) }
      }
    else
      "No exercises found for '#{query}'."
    end
  end
end
