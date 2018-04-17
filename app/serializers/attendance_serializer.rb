class AttendanceSerializer < ActiveModel::Serializer
  attributes :id, :date, :attendance_type, :comment, :student_id, :course_id
end
