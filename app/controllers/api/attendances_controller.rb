class Api::AttendancesController < Api::BaseController

  def index
    render json: Attendance.all
  end

  def show
    render json: Attendance.find(params[:id])
  end

  def create
    #there may be a more optimal way to search for a coursesStudent association
    courses_student = CoursesStudent.find_by(student__c: create_params[:student__c], class__c: create_params[:class__c])
    @attendance = courses_student.attendances.new(create_params.except(:id, :isChanged, :participant_enrollment__c, :student__c, :class__c))
    @attendance.participant_enrollment__c = courses_student.sfid
    if @attendance.save!
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
      :participant_enrollment__c,
      :start_date__c,
      :attendance_type__c,
      :notes__c,
      :student__c,
      :class__c,
    )
  end

  def update_params
    params.require(:attendance).permit(
      :id,
      :participant_enrollment__c,
      :start_date__c,
      :attendance_type__c,
      :notes__c,
      :student__c,
      :class__c,
    )
  end
end
