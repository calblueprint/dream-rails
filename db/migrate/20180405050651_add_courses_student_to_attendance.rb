class AddCoursesStudentToAttendance < ActiveRecord::Migration[5.1]
  def change
    add_reference :attendances, :courses_student, foreign_key: true
  end
end
