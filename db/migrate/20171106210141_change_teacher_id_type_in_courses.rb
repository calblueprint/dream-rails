class ChangeTeacherIdTypeInCourses < ActiveRecord::Migration[5.1]
  def change
    change_column :courses, :teacher_id1, :string
    change_column :courses, :teacher_id2, :string
  end
end
