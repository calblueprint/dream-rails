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
	enum program: {'Young Stars': 0, 'Montessori': 1, 'Summer Camp': 2, 'A Ganar': 3, 'Music': 4, 'Other': 5}
  has_many :courses_students, :dependent => :destroy
  has_many :students, :through => :courses_students
  has_many :attendances, :through => :courses_students
  has_and_belongs_to_many :teachers
  has_many :sessions, :dependent => :destroy
end
