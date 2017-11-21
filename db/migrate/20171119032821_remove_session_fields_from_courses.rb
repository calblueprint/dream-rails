class RemoveSessionFieldsFromCourses < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :weekday, :string
    remove_column :courses, :start_time, :datetime
    remove_column :courses, :end_time, :datetime
  end
end
