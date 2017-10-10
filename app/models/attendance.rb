# == Schema Information
#
# Table name: attendances
#
#  id              :integer          not null, primary key
#  student_id      :integer
#  course_id       :integer
#  date            :datetime
#  attendance_type :integer          default(0)
#  comment         :string
#  is_synced       :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Attendance < ApplicationRecord
end
