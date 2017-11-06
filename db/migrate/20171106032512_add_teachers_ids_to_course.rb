class AddTeachersIdsToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :teacher_id1, :integer
    add_column :courses, :teacher_id2, :integer
  end
end
