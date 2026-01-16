class Api::V1::ChatsController < Api::V1::BaseController
  def show
    chat = Current.user.chat || create_chat_for_user(Current.user)
    messages = chat.messages.where.not(role: :system).order(created_at: :asc)

    render json: {
      chat: chat,
      messages: messages.as_json(methods: [ :entities ])
    }
  end

  def create
    chat = Current.user.chat || create_chat_for_user(Current.user)

    chat.with_instructions(system_prompt)
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

    # The broadcast is handled by the Message model's after_create_commit
    render json: { status: "processing" }
  end

  private

  def create_chat_for_user(user)
    return user.chat if user.chat.present?

    if Rails.env.test?
      return Chat.new(user: user)
    end

    user.create_chat!(
      model: ENV.fetch("LLM_MODEL", "gemini-2.0-flash"),
      provider: ENV.fetch("LLM_PROVIDER", "google")
    )
  end

  def system_prompt
    <<~TEXT
      You are a helpful gym trainer assistant. Your goal is to help users manage their workout routines.
      You can create, edit, and archive routines.
      When a user asks to create a routine or add exercises, use the provided tools.

      CRITICAL: Before adding an exercise, ALWAYS search for it first using `search_exercise` to get the correct ID.
      CRITICAL: When a user wants to EDIT or DELETE/ARCHIVE something, use `list_user_routines` first to find the correct IDs (Routine ID, Day ID, or RoutineExercise ID).

      When the user says something like "Create a Push/Pull/Legs routine on Mon, Wed, Fri", you should:
      1. Create the routine.
      2. Add the days.
      3. Ask which exercises they want for each day if they didn't specify.

      If they want to change something, e.g., "Change Bench Press to 4 sets", find the RoutineExercise ID first then update it.
    TEXT
  end
end
