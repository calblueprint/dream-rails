class RemoveColumnsFromAttendances < ActiveRecord::Migration[5.1]
  def change
    remove_column :attendances, :student_id, :integer
    remove_column :attendances, :course_id, :integer
  end
end
