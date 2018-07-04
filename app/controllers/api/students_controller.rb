class Api::StudentsController < Api::BaseController

  def index
    if params[:course_id]
      student = Course.find(params[:course_id]).students
      render json: student
    else
		  render json: Student.all
    end
	end

	def search
		students = Student.where(first_name__c: params[:first_name__c], last_name__c: params[:last_name__c])
    render json: students
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
        :first_name__c,
        :last_name__c,
        :date_of_birth__c,
        :direccion__c,
        :nickname__c,
        :Contacto_Primario_Name__c,
        :Contacto_Primario_Phone__c,
        # :is_active,
        :sex__c,
        :usuario_de_facebook__c,
        :notes__c,
        :tipo_de_documento__c,
        # :level,
        :phone_number_1__c,
        :phone_number_2__c,
        :email__c,
        :idioma_principal__c,
        :nationality__c,
        # :past_dream_participant,
      )
  	end
end
