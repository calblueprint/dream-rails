# == Schema Information
#
# Table name: attendances
#
#  id                 :integer          not null, primary key
#  date               :string
#  attendance_type    :integer          default(0)
#  comment            :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  courses_student_id :integer
#

class Attendance < ApplicationRecord
	enum program: {'Present': 0, 'Unexcused Absent': 1, 'Excused Absent': 2, 'Unexcused Late': 3, 'Excused Late': 4}
  belongs_to :courses_student
	delegate :course_id, :student_id, to: :courses_student
end
