class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name
      t.string :dream_id
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
