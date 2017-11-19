class Api::CoursesController < Api::BaseController

  def index
    if params[:teacher_id]
      render json: Course.where(teacher_id1: params[:teacher_id]).or(
                   Course.where(teacher_id2: params[:teacher_id]))
    end
  end

  def show
    render json: Course.find(params[:id])
  end

  def create
    course = Course.new(course_params)
    errors = []
    add_teacher("teacher_id1", course, errors)
    add_teacher("teacher_id2", course, errors)
    if errors.present?
      return render_error_response(:forbidden, errors)
    end

    update_sessions(course)
    if course.save
      render json: course
    else
      render_error_response(:forbidden, course.errors.full_messages)
    end
  end

  def update
    course = Course.find(params[:id])
    if course.nil?
      return render_error_message(:forbidden, errors: ["Failed to update course."])
    end
    errors = []
    update_teacher("teacher_id1", course, errors)
    update_teacher("teacher_id2", course, errors)
    if errors.present?
      return render_error_response(:forbidden, errors)
    end

    update_sessions(course)
    if course.update(course_params)
      render json: course
    else
      render_error_response(:forbidden, course.errors.full_messages)
    end
  end

  def destroy
    course = Course.find(params[:id])
    if course.destroy
      render json: course
    else
      render_error_response(:forbidden, course.errors.full_messages)
    end
  end

  def sessions
    course = Course.find(params[:id])
    if !course.nil?
      render json: { sessions: course.sessions.order(:number) }
    else
      render_error_response(:forbidden, ["Could not retrieve sessions."])
    end
  end

  private

  def update_sessions(course)
    if params.key?("sessions") && params[sessions].any?
      params[sessions].each do |session_id|
        session = Session.find(session_id)
        unless course.sessions.include?(session)
          course.sessions << session
        end
      end
    end
  end

  def add_teacher(t_id, course, errors)
    if course_params[t_id].present?
      if Teacher.exists?(dream_id: course_params[t_id])
        new_t = Teacher.where(dream_id: course_params[t_id])
        course.teachers << new_t
      else
        errors << "No teacher with ID " + course_params[t_id].to_s
      end
    end
  end

  def update_teacher(t_id, course, errors)
    course_teacher_id = course.attributes[t_id]
    if course_teacher_id != course_params[t_id]
      # Remove old teacher
      if course_teacher_id.present?
        filtered_teachers = course.teachers.select { |old_t| old_t.dream_id != course_teacher_id }
        course.teachers = filtered_teachers
      end
      # Add new teacher
      add_teacher(t_id, course, errors)
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
      :teacher_id2,
      :teacher_id
    )
  end
end
