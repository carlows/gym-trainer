class Api::V1::ExercisesController < Api::V1::BaseController
  def index
    exercises = Exercise.all
    exercises = exercises.where("name LIKE ?", "%#{params[:q]}%") if params[:q].present?
    exercises = exercises.where(body_part: params[:body_part]) if params[:body_part].present?

    render json: exercises.limit(50)
  end

  def show
    exercise = Exercise.find(params[:id])
    render json: exercise
  end
end
