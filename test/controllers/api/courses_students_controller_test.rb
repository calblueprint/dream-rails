require 'test_helper'

class Api::CoursesStudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_courses_student = api_courses_students(:one)
  end

  test "should get index" do
    get api_courses_students_url, as: :json
    assert_response :success
  end

  test "should create api_courses_student" do
    assert_difference('Api::CoursesStudent.count') do
      post api_courses_students_url, params: { api_courses_student: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show api_courses_student" do
    get api_courses_student_url(@api_courses_student), as: :json
    assert_response :success
  end

  test "should update api_courses_student" do
    patch api_courses_student_url(@api_courses_student), params: { api_courses_student: {  } }, as: :json
    assert_response 200
  end

  test "should destroy api_courses_student" do
    assert_difference('Api::CoursesStudent.count', -1) do
      delete api_courses_student_url(@api_courses_student), as: :json
    end

    assert_response 204
  end
end
