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
    errors = []
    update_teacher("teacher_id1", course, errors)
    update_teacher("teacher_id2", course, errors)
    if errors.present?
      puts(errors) # DELETE
      return render_error_response(:forbidden, errors)
    end
    if course.save
      render json: course
    else
      render_error_response(:forbidden, course.errors.full_messages)
    end
  end

  def update
    course = Course.find(params[:id])
    errors = []
    update_teacher("teacher_id1", course, errors)
    update_teacher("teacher_id2", course, errors)
    if errors.present?
      puts(errors) # DELETE
      return render_error_response(:forbidden, errors)
    end
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

  def update_teacher(t_id, course, errors)
    if course_params.key?(t_id)
      course_teacher_id = course.attributes[t_id]
      params_teacher_id = course_params[t_id]

      # Remove old teacher
      puts("do not equal each other? ", course_teacher_id != params_teacher_id)
      if course_teacher_id.present? && course_teacher_id != params_teacher_id
        puts("REMOVING TEACHER NOWW!!!")
        puts("course_teacher_id: ", course_teacher_id)
        puts("params_teacher_id: ", params_teacher_id)
        puts("TEACHERS BEFORE REMOVE")
        puts(course.teachers)
        filtered_teachers = course.teachers.select { |old_t| old_t.dream_id != course_teacher_id }
        course.teachers = filtered_teachers
        puts("TEACHERS AFTER REMOVE")
        puts(course.teachers)
      end

      # Add teacher
      if Teacher.exists?(dream_id: params_teacher_id)
        new_t = Teacher.where(dream_id: params_teacher_id)
        course.teachers << new_t
        puts("TEACHERS AFTER ADD")
        puts(course.teachers)
      else
        errors << "No teacher with ID " + params_teacher_id.to_s
      end
    end
  end

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
