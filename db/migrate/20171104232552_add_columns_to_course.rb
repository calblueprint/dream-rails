class AddColumnsToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :start_date, :datetime
    add_column :courses, :end_date, :datetime
    add_column :courses, :weekday, :string
    add_column :courses, :start_time, :datetime
    add_column :courses, :end_time, :datetime
  end
end
