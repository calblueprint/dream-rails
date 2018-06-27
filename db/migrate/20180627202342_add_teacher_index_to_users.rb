class AddTeacherIndexToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_reference :users, :teacher, index: true
  end
end
