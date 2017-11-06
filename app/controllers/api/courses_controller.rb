class Api::CoursesController < Api::BaseController
  # TODO(caseytaka): fix authentication
  skip_before_action :verify_authenticity_token

  def index
    render json: Course.all
  end

  def show
    render json: Course.find(params[:id])
  end

  def create
    course = Course.new(course_params)

    if course_params.key?(:teacher_id1)
      if Teacher.exists?(dream_id: course_params[:teacher_id1])
        t1 = Teacher.where(dream_id: course_params[:teacher_id1])
        course.teachers << t1
      else
        puts("could not find teacher with id " + course_params[:teacher_id1].to_s)
        return render_error_response(:forbidden, ["Could not find teacher with ID " + course_params[:teacher_id1].to_s])
      end
    end

    if course_params.key?(:teacher_id2)
      if Teacher.exists?(dream_id: course_params[:teacher_id2])
      t2 = Teacher.where(dream_id: course_params[:teacher_id2])
      course.teachers << t2
      else
        puts("could not find teacher with id " + course_params[:teacher_id2].to_s)
        return render_error_response(:forbidden, ["Could not find teacher with ID " + course_params[:teacher_id2].to_s])
      end
    end

    if course.save
      render json: course
    else
      render_error_response(:forbidden, course.errors.full_messages)
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
    params.require(:course).permit(
      :title,
      :is_active,
      :start_date,
      :end_date,
      :weekday,
      :start_time,
      :end_time,
      :teacher_id1,
      :teacher_id2
    ).reject{|_, v| v.blank?}
  end
end
