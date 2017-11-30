class AttendanceDateToString < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :date, :string
  end
end
