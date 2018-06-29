class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?, only: [:new, :create]
  # skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    super do
      @user = User.new
      puts params
      @user = User.new(email: params[:teacher][:email], password: params[:teacher][:password], password_confirmation: params[:teacher][:password_confirmation])
      @user.teacher_id = @user.email
      puts "ok"
      @teacher = Teacher.new(email__c: params[:teacher][:email__c], first_name__c: params[:teacher][:first_name__c], last_name__c: params[:teacher][:last_name__c], phone_number_1__c: params[:teacher][:phone_number_1__c])
      @user.save
      @teacher.save
    end
  end

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
    end

end
