class RemoveForeignKeyCourseSessions < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :sessions, :courses
  end
end
