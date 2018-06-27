# == Schema Information
#
# Table name: courses_teachers
#
#  course_id  :integer          not null
#  teacher_id :integer          not null
#

class CoursesTeacher < ApplicationRecord
  belongs_to :course
  belongs_to :teacher 
end
