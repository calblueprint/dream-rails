class Api::AttendancesController < Api::BaseController

  def index
    render json: Attendance.all
  end

  def show
    render json: Attendance.find(params[:id])
  end

  def create
    #there may be a more optimal way to search for a coursesStudent association
    courses_student = CoursesStudent.find_by(student_id: create_params[:student_id],
      course_id: create_params[:course_id])
    @attendance = courses_student.attendances.create(create_params.except(:student_id, :course_id))
    if @attendance.save
      render json: @attendance
    else
      error_response(@attendance)
    end
  end

  def update
    @attendance = Attendance.find(update_params[:id])
    if @attendance.update(update_params)
      render json: @attendance
    else
      error_response(@attendance)
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    if @attendance.destroy
      render json: @attendance
    else
      error_response(@attendance)
    end
  end

  def attendance_item
    @attendance = Attendance.find_by_id(params[:attendance][:id])
    if @attendance
      update
    else
      create
    end
  end

  def create_params
    params.require(:attendance).permit(
      :student_id,
      :course_id,
      :date,
      :attendance_type,
      :comment,
    )
  end

  def update_params
    params.require(:attendance).permit(
      :id,
      :attendance_type,
      :comment,
    )
  end
end
