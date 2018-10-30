class Api::CoursesStudentsController < ApplicationController

  def index
  end

  def show
    #should just return a courses_student object based on :id
    render json: CoursesStudent.find(params[:id])
  end

  def create
    if CoursesStudent.exists?(class__c: courses_student_params[:class__c], student__c: courses_student_params[:student__c])
      return render_error_response(:forbidden, ["Student already enrolled in this course."])
    else
      courses_student = CoursesStudent.new(courses_student_params)
      if courses_student.save
        render json: courses_student
      else
        error_response(courses_student)
      end
    end
  end

  def update
  end

  def destroy
    courses_student = CoursesStudent.find_by(courses_student_params)
    if courses_student.destroy
      render json: courses_student
    else
      render_error_response(:forbidden, courses_student.errors.full_messages)
    end
  end

  # private
  def courses_student_params
    params.require(:courses_student).permit(
      :student__c,
      :class__c
    )
  end

end
