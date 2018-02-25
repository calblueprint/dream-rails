class AddProgramToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :program, :string
  end
end
