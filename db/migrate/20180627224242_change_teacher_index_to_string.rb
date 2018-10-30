class ChangeTeacherIndexToString < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :teacher_id, :string
  end
end
