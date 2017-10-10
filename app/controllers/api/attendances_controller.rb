class Api::AttendancesController < Api::BaseController
  def create
    @attendance = Attendance.new(create_params)
    if @attendance.save
      render json: @attendance
    else
    end
  end

  def destroy
    @task = Task.find(delete_params[:id])
    if @task.destroy
      render json: @task, serializer: TaskSerializer
    end
  end

  def create_params
    params.require(:attendance).permit(
      :student_id,
      :course_id,
      :date,
    )
  end
end
