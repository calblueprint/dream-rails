class Api::CoursesStudentsController < ApplicationController

  # GET /api/courses_students
  # GET /api/courses_students.json
  def index
  end

  # GET /api/courses_students/1
  # GET /api/courses_students/1.json
  # Renders all enrolled students associated with a given course id.
  def show
    courses_students = CoursesStudent.where(:course_id => params[:course_id]).to_a
    students = Array.new
    for e in courses_students
      students.push(Student.find(e.student_id))
    end
    render json: students
  end

  # POST /api/courses_students
  # POST /api/courses_students.json
  def create
    courses_student = CoursesStudent.new(courses_student_params)
    if courses_student.save
      render json: courses_student
    else
      error_response(courses_student)
    end
  end

  # PATCH/PUT /api/courses_students/1
  # PATCH/PUT /api/courses_students/1.json
  def update
  end

  # DELETE /api/courses_students/1
  # DELETE /api/courses_students/1.json
  def destroy
    courses_student = CoursesStudent.find(params[:id])
    if courses_student.destroy
      render json: courses_student
    else
      render_error_response(:forbidden, courses_student.errors.full_messages)
    end
  end

  def courses_student_params
    params.require(:courses_student).permit(
      :student_id,
      :course_id
    )
  end
end
