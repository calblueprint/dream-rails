class ChangeCourseStudentsRefInAttendance < ActiveRecord::Migration[5.1]
  def change
  	remove_column :attendances, :courses_student_id, :integer
  	add_column :attendances, :courses_student_id, :string
  end
end
