class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?, only: [:new, :create]
  # skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    super
  end

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
    end

end
