class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_api_user!, only: [ :create ]

  def show
    render json: {
      user: {
        identifier: Current.user.identifier
      }
    }
  end

  def create
    user = User.find_or_create_by!(identifier: params[:identifier])
    # We still set the cookie for traditional use, but the API will prefer the header
    cookies.signed[:user_id] = { value: user.id, expires: 1.month.from_now }
    render json: {
      message: "Logged in successfully",
      user: { identifier: user.identifier }
    }, status: :created
  end

  def destroy
    cookies.delete(:user_id)
    render json: { message: "Logged out successfully" }
  end
end
