class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.integer :student_id
      t.integer :course_id
      t.datetime :date
      t.integer :attendance_type
      t.string :comment
      t.boolean :is_synced

      t.timestamps
    end
  end
end
