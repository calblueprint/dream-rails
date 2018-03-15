class AddFieldsToStudents < ActiveRecord::Migration[5.1]
  def change
  	add_column :students, :is_active, :boolean
  	add_column :students, :sex, :string
  	add_column :students, :facebook_name, :string 
  	add_column :students, :notes, :string
  	add_column :students, :document_type, :string
  	add_column :students, :level, :string
  	add_column :students, :phone, :string
  	add_column :students, :phone_2, :string
  	add_column :students, :email, :string
  	add_column :students, :primary_language, :string
  	add_column :students, :past_dream_participant, :boolean
  end
end
