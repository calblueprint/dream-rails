class Api::AttendancesController < Api::BaseController
  # TODO: fix
  skip_before_action :verify_authenticity_token

  def index
    render json: Attendance.all
  end

  def show
    render json: Attendance.find(params[:id])
  end

  def create
    @attendance = Attendance.new(create_params)
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
    @attendance = Attendance.find_by(create_params)
    if @attendance
      render json: @attendance
    else
      create
    end
  end

  def create_params
    params.require(:attendance).permit(
      :student_id,
      :course_id,
      :date,
    )
  end

  def update_params
    params.require(:attendance).permit(
      :id,
      :attendance_type,
      :comment,
      :is_synced
    )
  end
end
