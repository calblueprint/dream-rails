class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include CanCan::ControllerAdditions
  respond_to :json

  def not_found_response
    error_response(nil, "Not Found", 404)
  end

  def success_response(message = nil)
    render json: Success.new(message), serializer: SuccessSerializer
  end

  def error_response(object, message = nil, status = nil)
    render json: Error.new(object, message), serializer: ErrorSerializer, status: status || 400
  end

  def render_error_response(status, errors)
    render json: { errors: errors }, status: status
  end

  # CanCanCan
  def current_user
    current_teacher
  end

  def current_ability
    @current_ability ||= ::Abilities::Ability.new(current_user)
  end
end
