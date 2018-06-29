class Api::UsersController < Api::BaseController
	
	def create
  	@user = User.new
  	@user = User.new(user_params)
    @user.teacher_id = @user.email
    puts "ok"
    @teacher = Teacher.new(email__c: params[:user][:email__c], first_name__c: params[:user][:first_name__c], last_name__c: params[:user][:last_name__c], phone_number_1__c: params[:user][:phone_number_1__c])
    @teacher.save
    @user.save
  end

	private

		def user_params
	  	params.require(:user).permit(:email, :password, :password_confirmation, teacher_attributes: [:first_name__c, :last_name__c, :email__c, :phone_number_1__c])
		end

end