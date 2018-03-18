class Api::CoursesStudentsController < ApplicationController
<<<<<<< HEAD
  # before_action :set_api_courses_student, only: [:show, :update, :destroy]
=======
>>>>>>> ed70a078fbc8444d16ac6ef8d37d266c67afcf6c

  # GET /api/courses_students
  # GET /api/courses_students.json
  def index
  end

  # GET /api/courses_students/1
  # GET /api/courses_students/1.json
  # Renders all enrolled students associated with a given course id.
  def show

    #should just return a courses_student object based on :id
    render json: CoursesStudent.find(params[:id])


    # courses_students = CoursesStudent.find(:course_id => params[:course_id]).to_a
    # students = Array.new
    # courses_students.each do |e| 
    #   students.push(Student.find(e.student_id))
    # end
    # render json: students
    courses_students = CoursesStudent.where(:course_id => params[:course_id]).to_a
    students = Array.new
    for e in courses_students
      students.push(Student.find(e.student_id))
    end
    render json: students
  end

  # def students
  #   course_ = Teacher.find(params[:teacher_id])
  #   if !teacher.nil?
  #     render json: teacher.courses.order(:id)
  #   else
  #     render_error_response(:forbidden, ["Could not retrieve courses."])
  #   end
  # end

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

  # private
  def courses_student_params
    params.require(:courses_student).permit(
      :student_id,
      :course_id
    )
  end

end
