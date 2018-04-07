# == Schema Information
#
# Table name: students
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  address         :string
#  year            :integer
#  nickname        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  emergency_name  :string
#  phone           :string
#  emergency_phone :string
#  teacher_id      :integer
#  birthday        :date
#

class Student < ApplicationRecord
	enum sex: {'Female': 0, 'Male': 1}
	enum document_type: {'None': 0, 'Govt. ID card': 1, 'Passport or foreign birth certificate': 2, 'Regularization card': 3, 
		'Dominican birth certificate': 4, 'Dominican birth cetificate that says foreigner': 5}
	enum level: {'Maternal': 0, 'Kinder': 1, 'Pre-Primaria': 2, 'Primero': 3, 'Segundo': 4}
	enum primary_language: {'Spanish': 0, 'Creole': 1, 'Other': 2}
  has_many :courses_students
  has_many :courses, :through => :courses_students
  validates :first_name, :last_name, :birthday, 
  :address, :phone, :facebook_name, :email, 
  :primary_contact, :primary_contact_phone, 
  #is_active, :sex, :document_type,
  presence: true
end
