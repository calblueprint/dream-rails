class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?, only: [:new, :create]
  # skip_before_action :verify_authenticity_token
  respond_to :json

  #TODO: Render Error Message that states "User account already exists."
  def create
    super do
      if !User.exists?(email: params[:teacher][:email])
        @user = User.new
        @user = User.new(email: params[:teacher][:email], password: params[:teacher][:password], password_confirmation: params[:teacher][:password_confirmation])
        @user.teacher_id = @user.email
        if !Teacher.exists?(email__c: params[:teacher][:email])
          @teacher = Teacher.new(email__c: params[:teacher][:email], first_name__c: params[:teacher][:first_name__c], last_name__c: params[:teacher][:last_name__c], phone_number_1__c: params[:teacher][:phone_number_1__c])
          @teacher.save
        end
        @user.save
      end
    end
  end

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
    end

end
