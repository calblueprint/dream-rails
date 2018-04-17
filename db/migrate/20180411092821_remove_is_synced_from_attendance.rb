class RemoveIsSyncedFromAttendance < ActiveRecord::Migration[5.1]
  def change
    remove_column :attendances, :is_synced, :boolean
  end
end
