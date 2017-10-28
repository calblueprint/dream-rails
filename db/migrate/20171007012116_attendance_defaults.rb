class AttendanceDefaults < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :attendance_type, :integer, :default => 0
    change_column :attendances, :is_synced, :boolean, :default => false
  end
end
