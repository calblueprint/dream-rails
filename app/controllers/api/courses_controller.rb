class Api::CoursesController < Api::BaseController

  def index
    render json: Course.order(:id).all
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

    if course.save
      # Need to wait until have course_id to create sessions
      update_sessions(course, errors)
      if errors.present?
        return render_error_response(:forbidden, errors)
      else
        render json: course
      end
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
    update_sessions(course, errors)
    if errors.present?
      return render_error_response(:forbidden, errors)
    end

    update_teacher("teacher_id1", course, errors)
    update_teacher("teacher_id2", course, errors)
    if errors.present?
      return render_error_response(:forbidden, errors)
    end

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
    course = Course.find(params[:course_id])
    if !course.nil?
      render json: { sessions: course.sessions.order(:number) }
    else
      render_error_response(:forbidden, ["Could not retrieve sessions."])
    end
  end

  def teachers
    course = Course.find(params[:course_id])
    if !course.nil?
      render json: { teachers: course.teachers }
    else
      render_error_response(:forbidden, ["Could not retrieve course teachers."])
    end
  end

  private

  def update_sessions(course, errors)
    # Delete sessions from course not present in params[:sessions]
    delete_sessions(course, errors)

    # Create/update modified sessions
    params[:sessions].each do |s|
      if s[:modified]
        if s[:id].present?
          # Update session if it exists
          session = Session.find(s[:id])
        else
          # Create session
          session = Session.new
          session.course_id = course.id
        end

        update_session_attrs(session, s)
        if !session.save
          errors << "Session not updated."
        end
      end
    end
  end

  def delete_sessions(course, errors)
    # Delete sessions not present in both params[:sessions] and course.sessions
    course_sessions_ids = course.sessions.ids
    course_sessions_ids.each do |s_id|
      found = params[:sessions].find { |session| session[:id] == s_id }
      if found.nil?
        session = Session.find(s_id)
        if !session.destroy
          errors << "Session not deleted"
        end
      end
    end
  end

  def update_session_attrs(session, s_params)
    session.weekday = s_params[:weekday]
    session.start_time = s_params[:start_time]
    session.end_time = s_params[:end_time]
    session.number = s_params[:number]
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
      :course_name,
      :is_active,
      :start_date,
      :end_date,
      :teacher_id1,
      :teacher_id2,
      :course_nickname,
      :site,
      :program,
      :notes
    )
  end
end
