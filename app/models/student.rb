# == Schema Information
#
# Table name: students
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  birthday               :string
#  address                :string
#  nickname               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  primary_contact        :string
#  primary_contact_phone  :string
#  dream_id               :string
#  is_active              :integer
#  sex                    :integer
#  facebook_name          :string
#  notes                  :string
#  document_type          :integer
#  level                  :integer
#  phone                  :string
#  phone_2                :string
#  email                  :string
#  primary_language       :integer
#  past_dream_participant :integer
#

class Student < ApplicationRecord
	enum sex: {'Female': 0, 'Male': 1}
	enum document_type: {'None': 0, 'Govt. ID card': 1, 'Passport or foreign birth certificate': 2, 
		'Regularization card': 3, 'Dominican birth certificate': 4, 'Dominican birth cetificate that says foreigner': 5}
	enum level: {'Maternal': 0, 'Kinder': 1, 'Pre-Primaria': 2, 'Primero': 3, 'Segundo': 4}
	enum primary_language: {'Spanish': 0, 'Creole': 1, 'Other': 2}
	enum is_active: {'Yes': 0, 'No': 1}, _prefix: true
	enum past_dream_participant: {'Yes': 0, 'No': 1}, _prefix: true

  has_many :courses_students
  has_many :courses, :through => :courses_students
	has_many :attendances, :through => :courses_students
  validates :first_name, :last_name, :birthday, 
  :phone, presence: true
end
