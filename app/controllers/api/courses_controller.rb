class Api::CoursesController < Api::BaseController
  # TODO: Uncomment when auth_token is ready
  # load_and_authorize_resource

  def index
    render json: Course.order(:id).all
  end

  def show
    render json: Course.find(params[:id])
  end

  def create
    course = Course.new(course_params)
    errors = []
    add_teacher("facilitator_1__c", course, errors)
    add_teacher("facilitator_2__c", course, errors)
    add_program("program__c", course, errors)
    if errors.present?
      return render_error_response(:forbidden, errors)
    end

    if course.save
      # Need to wait until have course_id to create sessions
      # update_sessions(course, errors)
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

    if course.update(course_update_params)
      update_teacher("facilitator_1__c", course, errors)
      update_teacher("facilitator_2__c", course, errors)
      if errors.present?
        return render_error_response(:forbidden, errors)
      end
      course.save
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
      render json: { teachers: [course.facilitator_1__c, course.facilitator_2__c] }
    else
      render_error_response(:forbidden, ["Could not retrieve course teachers."])
    end
  end

  def students
    course = Course.find(params[:course_id])
    if !course.nil?
      render json: course.students.order(:id), each_serializer: StudentSerializer, scope: {
        class__c: course.id
      }
    else
      render_error_response(:forbidden, ["Could not retrieve students."])
    end
  end

  def recent_attendances
    course = Course.find(params[:course_id])
    if !course.nil?
      dateDict = course.attendances.group_by(&:start_date__c)
      sortedKeys = dateDict.keys.last(5)
      recentsDict = dateDict.keep_if {|k,_| sortedKeys.include? k }
      puts 'ok'
      render json: recentsDict.transform_values { |a| a.map { |e| AttendanceSerializer.new(e)} }
    else
      render_error_response(:forbidden, ["Could not retrieve sessions."])
    end
  end

  def month_attendances
    course = Course.find(params[:course_id])
    date = Date.parse params[:date]
    if !course.nil?
      dateDict = course.attendances.group_by(&:start_date__c)
      monthDict = dateDict.keys.group_by { |a| a.beginning_of_month }
      dates = monthDict[date.beginning_of_month]
      if dates.nil?
        render json: {}
      else
        monthAttendances = Hash[dates.collect { |date| [date, dateDict[date]] } ]
        render json: monthAttendances.transform_values { |a| a.map { |e| AttendanceSerializer.new(e)}}
      end
    else
      render_error_response(:forbidden, ["Could not retrieve sessions."])
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
        if !session.save!
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

  def add_program(pName, course, errors)
    if course_params[pName].present?
      if Program.exists?(name: course_params[pName])
        new_p = Program.where(name: course_params[pName])
        course.program__c = new_p.pluck(:sfid)[0]
      else
        errors << "No Program named " + course_params[pName].to_s
      end
    end
  end

  def add_teacher(tID, course, errors)
    if course_params[tID].present?
      if Teacher.exists?(email__c: course_params[tID])
        new_t = Teacher.where(email__c: course_params[tID])
        if tID == "facilitator_1__c"
          course.facilitator_1__c = new_t.pluck(:sfid)[0]
          course.f1_email__c = new_t.pluck(:email__c)[0]
          course.f1_first_name__c = new_t.pluck(:first_name__c)[0]
          course.f1_last_name__c = new_t.pluck(:last_name__c)[0]
        else
          course.facilitator_2__c = new_t.pluck(:sfid)[0]
          course.f2_email__c = new_t.pluck(:email__c)[0]
          course.f2_first_name__c = new_t.pluck(:first_name__c)[0]
          course.f2_last_name__c = new_t.pluck(:last_name__c)[0]
        end
      else
        errors << "No teacher with email " + course_params[tID].to_s
      end
    end
  end

  def update_teacher(t_id, course, errors)
    course_teacher_sfid = course.attributes[t_id]
    course_teacher_email__c = Teacher.where(sfid: course_teacher_sfid).pluck(:email__c)[0]
    if course_teacher_email__c != course_params[t_id]
      # Add new teacher
      add_teacher(t_id, course, errors)
    end
  end

  #add student method

  def course_params
    params.require(:course).permit(
      :title__c,
      :is_active,
      :start_date__c,
      :end_date__c,
      :facilitator_1__c,
      :facilitator_2__c,
      :program__c,
      :course_nickname,
      :site,
      :notes
    )
  end

  def course_update_params
    params.require(:course).permit(
      :title__c,
      :is_active,
      :start_date__c,
      :end_date__c,
      :course_nickname,
      :site,
      :program,
      :notes
    )
  end
end
