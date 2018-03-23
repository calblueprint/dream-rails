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
  has_many :courses_students
  has_many :students, :through => :courses_students
  has_and_belongs_to_many :teachers
  has_many :sessions, :dependent => :destroy
end
