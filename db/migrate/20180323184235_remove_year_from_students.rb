class RemoveYearFromStudents < ActiveRecord::Migration[5.1]
  def change
  	remove_column :students, :year, :integer
  end
end
