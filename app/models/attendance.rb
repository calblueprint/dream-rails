# == Schema Information
#
# Table name: attendances
#
#  id              :integer          not null, primary key
#  student_id      :integer
#  course_id       :integer
#  date            :date
#  attendance_type :integer          default(0)
#  comment         :string
#  is_synced       :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Attendance < ApplicationRecord
	enum program: {'Present': 0, 'Unexcused Absent': 1, 'Excused Absent': 2, 'Unexcused Late': 3, 'Excused Late': 4}
  belongs_to :course
  belongs_to :student
end
