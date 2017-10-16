class AddEmergencyAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :emergency_name, :string
    add_column :students, :phone, :string
    add_column :students, :emergency_phone, :string
  end
end
