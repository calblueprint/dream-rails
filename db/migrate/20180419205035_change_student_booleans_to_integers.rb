class ChangeStudentBooleansToIntegers < ActiveRecord::Migration[5.1]
  def change
  	change_column :students, :is_active, 'integer USING CAST(is_active AS integer)'
  	change_column :students, :past_dream_participant, 'integer USING CAST(past_dream_participant AS integer)'
  end
end
