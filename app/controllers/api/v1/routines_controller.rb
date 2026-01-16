class Api::V1::RoutinesController < Api::V1::BaseController
  def index
    routines = Current.user.routines.where(archived_at: nil)
    render json: routines.as_json(include: {
      routine_days: {
        include: {
          routine_exercises: { include: :exercise }
        }
      }
    })
  end

  def show
    routine = Current.user.routines.find(params[:id])
    render json: routine.as_json(include: {
      routine_days: {
        include: {
          routine_exercises: { include: :exercise }
        }
      }
    })
  end
end
