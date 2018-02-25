class AddProgramToTeachers < ActiveRecord::Migration[5.1]
  def change
    add_column :teachers, :program, :string
  end
end
