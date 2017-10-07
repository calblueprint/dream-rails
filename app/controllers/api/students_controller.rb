class Api::StudentsController < Api::ApplicationController
	def index
		render json: Student.all

	def show
		render json: Student.find(params[:id])
	end

	def create
		@student = Student.new(student_params)
 
  		if @student.save
  			render json: course
  		else
  			error_response(student)
  		end
	end

	def new
		@student = Student.new
	end

	def update
    	@student = Student.find(params[:id])
     	if @student.update(student_params)
       		render json: student
     	else
       		error_response(student)
     	end
   	end

	def edit
		@student = Student.find(params[:id])

	def destroy
		@student = Student.find(params[:id])
		if @student.destroy
			render json: student
		else
			error_response(student)
		end
	end

	private
		def student_params
			params.require(:student).permit(:first_name, :last_name, :birthday, :year, :address, :nickname)
		end

end
