class ApplicationController < ActionController::API
  include Pundit
  include Auth

  rescue_from Pundit::NotAuthorizedError, with: :rescue_pundit

  def rescue_pundit(error)
    render json: { message: error.message }, status: :unauthorized and return
  end
end
