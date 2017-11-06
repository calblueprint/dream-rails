class CreateJoinTableCourseTeacher < ActiveRecord::Migration[5.1]
  def change
    create_join_table :courses, :teachers do |t|
      # t.index [:course_id, :teacher_id]
      # t.index [:teacher_id, :course_id]
    end
  end
end
