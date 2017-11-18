class AddAttributesToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :primary_contact, :string
    add_column :students, :primary_contact_relationship, :string
    add_column :students, :primary_contact_phone, :string
    add_column :students, :primary_contact_phone2, :string
    add_column :students, :course_id, :integer
    add_column :students, :teacher_id, :integer
  end
end
