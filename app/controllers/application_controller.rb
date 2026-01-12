class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate
  before_action :set_current_user

  private

  def authenticate
    if (user_id = cookies.signed[:user_id])
      Current.user = User.find_by(id: user_id)
    end

    redirect_to new_session_path unless Current.user || controller_name == "sessions"
  end

  def set_current_user
    @current_user = Current.user
  end
end
