class Api::StudentsController < Api::BaseController

  def index
    if params[:course_id]
      student = Course.find(params[:course_id]).students
      render json: student
    else
		  render json: Student.all
    end
  end

	def show
    student = Student.find(params[:id])
    render json: student
	end

	def create
		student = Student.new(student_params)
    if student.save
      render json: student
    else
      error_response(student)
    end
	end

	def update
  	student = Student.find(params[:id])
   	if student.update(student_params)
   		render json: student
   	else
   		error_response(student)
   	end
   end

	def destroy
		student = Student.find(params[:id])
		if student.destroy
			render json: student
		else
			error_response(student)
		end
	end

	private
  	def student_params
  		params.require(:student).permit(
        :first_name,
        :last_name,
        :birthday,
        :address,
        :dream_id,
        :nickname,
        :primary_contact,
        :primary_contact_phone,
        :is_active,
        :sex,
        :facebook_name,
        :notes,
        :document_type,
        :level,
        :phone,
        :phone_2,
        :email,
        :primary_language,
        :past_dream_participant
      )
  	end
end
