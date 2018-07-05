class ChangeCourseIDtoString < ActiveRecord::Migration[5.1]
  def change
  	remove_column :sessions, :course_id, :integer
  	add_column :sessions, :course_id, :string
  end
end
