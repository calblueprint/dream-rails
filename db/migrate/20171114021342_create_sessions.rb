class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :weekday
      t.datetime :start_time
      t.datetime :end_time
      t.integer :number

      t.timestamps
    end
  end
end
