class RemoveUnusedFields < ActiveRecord::Migration[5.1]
  def change
  	remove_column :students, :primary_contact_relationship, :string
  	remove_column :students, :primary_contact_phone2, :string
  end
end
