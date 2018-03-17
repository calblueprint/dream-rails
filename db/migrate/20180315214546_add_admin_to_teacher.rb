class AddAdminToTeacher < ActiveRecord::Migration[5.1]
  def change
    add_column :teachers, :admin, :boolean, default: false
  end
end
