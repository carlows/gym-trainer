class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate
  skip_before_action :set_current_user

  # Since we're using the same identifier-based auth, we can leverage Current.user
  before_action :authenticate_api_user!

  private

  def authenticate_api_user!
    identifier = request.headers["X-User-Identifier"]
    if identifier.present?
      Current.user = User.find_by(identifier: identifier)
    end

    unless Current.user
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
