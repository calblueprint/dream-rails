class ChangeBirthdayToDatetime < ActiveRecord::Migration[5.1]
  def change
    remove_column :students, :birthday
    add_column :students, :birthday, :date
  end
end
