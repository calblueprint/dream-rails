class AddCourseReferenceToSessions < ActiveRecord::Migration[5.1]
  def change
    add_reference :sessions, :course, index: true, foreign_key: true
  end
end
