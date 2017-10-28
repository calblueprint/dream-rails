class ChangeAttendanceDate < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :date, :date
  end
end
