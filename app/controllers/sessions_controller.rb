class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [ :new, :create ]

  def new
  end

  def create
    user = User.find_or_create_by(identifier: params[:identifier].to_s.strip.downcase)
    if user.persisted?
      cookies.signed[:user_id] = { value: user.id, expires: 1.month.from_now }
      redirect_to root_path, notice: "Logged in as #{user.identifier}"
    else
      flash.now[:alert] = "Could not log in"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to new_session_path, notice: "Logged out"
  end
end
