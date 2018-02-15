class RenameCourseStudentsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :course_students, :courses_students
  end
end
