class CoursesStudent < ApplicationRecord
	belongs_to :student
	belongs_to :course
	has_many :attendances
end
