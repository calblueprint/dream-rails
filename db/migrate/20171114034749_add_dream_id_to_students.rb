class AddDreamIdToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :dream_id, :string
  end
end
