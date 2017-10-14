class AddCourseAndTeacher < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :course_id, :integer
    add_column :students, :teacher_id, :integer
  end
end
