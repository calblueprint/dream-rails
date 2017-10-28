
class Api::TeachersController < Api::BaseController

    skip_before_action :verify_authenticity_token
    
    def new
      @teacher = Teacher.new
    end

    def create
      @teacher = Teacher.new(teacher_params)
       
      if @teacher.save
        render json: @teacher
      else
        error_response(@teacher)
      end
    end

    def update
      @teacher = Teacher.find(params[:id])
       
      if @teacher.update(teacher_params)
        render json: @teacher
      else
        error_response(@teacher)
      end
    end

    def edit
      @teacher = Teacher.find(params[:id])
    end

    def show 
      @teacher = Teacher.find(params[:id])
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

    private
      def teacher_params
        params.require(:teacher).permit(:first_name, :last_name, :dream_id, :email, :phone)
      end

  end
