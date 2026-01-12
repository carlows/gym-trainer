class DashboardController < ApplicationController
  def index
    @routines = Current.user.routines.active.includes(routine_days: :routine_exercises)
    @sessions = Current.user.sessions.includes(:routine, :session_exercises).order(completed_at: :desc).limit(10)
  end
end
