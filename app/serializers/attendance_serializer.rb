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

class AttendanceSerializer < ActiveModel::Serializer
  attributes :id, :date, :attendance_type, :comment, :student_id, :course_id
end
