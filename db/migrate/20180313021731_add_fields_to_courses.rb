class AddFieldsToCourses < ActiveRecord::Migration[5.1]
  def change
  	add_column :courses, :course_nickname, :string
  	add_column :courses, :site, :string
  	add_column :courses, :program, :string
  	add_column :courses, :notes, :string
  end
end
