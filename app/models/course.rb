# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  title      :string
#  is_active  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Course < ApplicationRecord
  has_many :students

  has_many :courses_teachers
  has_many :teachers, through: :courses_teachers
  
  has_many :attendances
  has_many :sessions, :dependent => :destroy
end
