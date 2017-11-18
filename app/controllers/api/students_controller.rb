class Api::StudentsController < Api::BaseController
	# TODO: remove
  skip_before_action :verify_authenticity_token

  def index
    if params[:course_id]
      @student = Course.find(params[:course_id]).students
      render json: @student
    else
		    render json: Student.all
    end
  end

	def show
    @student = Student.find(params[:id])
    render json: @student
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
  	@student = Student.find(params[:id])
   	if @student.update(student_params)
   		render json: @student
   	else
   		error_response(@student)
   	end
   end

	def destroy
		@student = Student.find(params[:id])
		if @student.destroy
			render json: @student
		else
			error_response(@student)
		end
	end

	private
  	def student_params
  		params.require(:student).permit(
        :first_name,
        :last_name,
        :birthday,
        :year,
        :address,
        :course_id,
        :teacher_id,
      )
  	end
end
