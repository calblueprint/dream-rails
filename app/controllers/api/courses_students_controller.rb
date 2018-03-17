class Api::CoursesStudentsController < ApplicationController
  before_action :set_api_courses_student, only: [:show, :update, :destroy]

  # GET /api/courses_students
  # GET /api/courses_students.json
  def index
    @api_courses_students = Api::CoursesStudent.all
  end

  # GET /api/courses_students/1
  # GET /api/courses_students/1.json
  def show
  end

  # POST /api/courses_students
  # POST /api/courses_students.json
  def create
    @api_courses_student = Api::CoursesStudent.new(api_courses_student_params)

    if @api_courses_student.save
      render :show, status: :created, location: @api_courses_student
    else
      render json: @api_courses_student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/courses_students/1
  # PATCH/PUT /api/courses_students/1.json
  def update
    if @api_courses_student.update(api_courses_student_params)
      render :show, status: :ok, location: @api_courses_student
    else
      render json: @api_courses_student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/courses_students/1
  # DELETE /api/courses_students/1.json
  def destroy
    @api_courses_student.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_courses_student
      @api_courses_student = Api::CoursesStudent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_courses_student_params
      params.fetch(:api_courses_student, {})
    end
end
