class Api::V1::WorkoutsController < Api::V1::BaseController
  def index
    sessions = Current.user.sessions.order(created_at: :desc)
    render json: sessions.as_json(include: { session_exercises: { include: :exercise } })
  end

  def create
    routine = Current.user.routines.find(params[:routine_id])
    session = Current.user.sessions.create!(routine: routine, completed_at: Time.current)

    params[:exercises].each do |ex_param|
      session.session_exercises.create!(
        exercise_id: ex_param[:exercise_id],
        sets: ex_param[:sets],
        reps: ex_param[:reps]
      )
    end

    render json: session.as_json(include: { session_exercises: { include: :exercise } }), status: :created
  end

  def show
    session = Current.user.sessions.find(params[:id])
    render json: session.as_json(include: { session_exercises: { include: :exercise } })
  end
end
