class ChatsController < ApplicationController
  def show
    @chat = Current.user.chat || Current.user.create_chat!(model: "gemini-2.5-flash", provider: "vertexai")
    @messages = @chat.messages.where.not(role: :system).order(created_at: :asc)
  end

  def create
    @chat = Current.user.chat || Current.user.create_chat!(model: "gemini-2.5-flash", provider: "vertexai")

    # We use RubyLLM's ask method which handles persistence automatically
    @chat.with_instructions(system_prompt)
      .with_tools(
        CreateRoutineTool,
        AddDayToRoutineTool,
        SearchExerciseTool,
        AddExerciseToRoutineDayTool,
        ArchiveRoutineTool,
        ListUserRoutinesTool,
        UpdateRoutineExerciseTool,
        RemoveExerciseFromRoutineTool,
        RemoveDayFromRoutineTool
      )
      .ask(params[:content])

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path }
    end
  end

  private

  def system_prompt
    <<~TEXT
      You are a helpful gym trainer assistant. Your goal is to help users manage their workout routines.
      You can create, edit, and archive routines.
      When a user asks to create a routine or add exercises, use the provided tools.

      CRITICAL: Before adding an exercise, ALWAYS search for it first using `search_exercise` to get the correct ID.
      CRITICAL: When a user wants to EDIT or DELETE/ARCHIVE something, use `list_user_routines` first to find the correct IDs (Routine ID, Day ID, or RoutineExercise ID).

      The days of the week are: monday, tuesday, wednesday, thursday, friday, saturday, sunday.

      When the user says something like "Create a Push/Pull/Legs routine on Mon, Wed, Fri", you should:
      1. Create the routine.
      2. Add the days.
      3. Ask which exercises they want for each day if they didn't specify.

      If they want to change something, e.g., "Change Bench Press to 4 sets", find the RoutineExercise ID first then update it.
    TEXT
  end
end
