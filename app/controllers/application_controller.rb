class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
end
