class Api::TeachersController < Api::BaseController
  # TODO: Uncomment when auth_token is ready
  # load_and_authorize_resource

  def update
    @teacher = Teacher.find(params[:id])

    # Cannot update teacher dream_id if teacher already has courses
    if (teacher_params[:dream_id].to_s != @teacher.dream_id) && @teacher.courses.present?
      return render_error_response(:forbidden, ["Cannot change dream ID. Courses are already linked to your account."])
    end

    if @teacher.update(teacher_params)
      render json: @teacher
    else
      error_response(@teacher)
    end
  end

  def show
    puts "lets go"
    puts params[:id]+".com"
    @teacher = Teacher.find(params[:id]+".com")
    puts @teacher
    render json: @teacher
  end

  def index
    @teachers = Teacher.all
    render json: @teachers
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    if @teacher.destroy
      render json: @teacher
    else
      error_response(@teacher)
    end
  end

  def courses
    teacher = Teacher.find(params[:teacher_id])
    if !teacher.nil?
      render json: teacher.courses.order(:id)
    else
      render_error_response(:forbidden, ["Could not retrieve courses."])
    end
  end

  private

    def teacher_params
      params.require(:teacher).permit(:first_name, :last_name, :email, :phone)
    end
    
end
