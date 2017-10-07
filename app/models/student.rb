class Student < ApplicationRecord
  belongs_to :course
  belongs_to :teacher
  validates :first_name, :last_name, :birthday, :year, :address, presence: true

  # to be edited
  enum emergency_contact:[
  	:first_name,
  	:last_name,
  	:phone,
  ]

end
