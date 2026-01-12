class WorkoutsController < ApplicationController
  def new
    @routine = Current.user.routines.find(params[:routine_id])
    @day = params[:day] || Date.today.strftime("%A").downcase
    @routine_day = @routine.routine_days.find_by(day_of_week: @day) || @routine.routine_days.first

    if @routine_day.nil?
      redirect_to root_path, alert: "This routine has no exercises scheduled."
      return
    end

    @exercises = @routine_day.routine_exercises.includes(:exercise)
    @session = Current.user.sessions.build(routine: @routine)
  end

  def create
    @routine = Current.user.routines.find(params[:session][:routine_id])
    @session = Current.user.sessions.create!(routine: @routine, completed_at: Time.current)

    params[:exercises].each do |exercise_id, data|
      next if data[:sets].blank? || data[:reps].blank?
      @session.session_exercises.create!(
        exercise_id: exercise_id,
        sets: data[:sets],
        reps: data[:reps],
        weight: data[:weight].presence
      )
    end

    redirect_to root_path, notice: "Workout saved!"
  end

  def show
    @session = Current.user.sessions.includes(session_exercises: :exercise).find(params[:id])
  end
end
