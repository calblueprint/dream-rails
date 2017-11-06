class Api::CoursesController < Api::BaseController
  # TODO: fix authentication
  skip_before_action :verify_authenticity_token

  def index
    render json: Course.all
  end

  def show
    render json: Course.find(params[:id])
  end

  def create
    course = Course.new(course_params)
    if course.save
      render json: course
    else
      error_response(course)
    end
  end

  def update
    course = Course.find(params[:id])
    if course.update(course_params)
      render json: course
    else
      error_response(course)
    end
  end

  def destroy
    course = Course.find(params[:id])
    if course.destroy
      render json: course
    else
      error_response(course)
    end
  end

  private

  def course_params
    params.permit(:title, :is_active, :start_date, :end_date, :weekday, :start_time, :end_time, :teacher_id1, :teacher_id2)
  end
end
