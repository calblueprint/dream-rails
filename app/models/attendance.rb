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
  belongs_to :courses_student, foreign_key: 'sfid'
	delegate :class__c, :student__c, to: :courses_student
	self.table_name = 'salesforce.attendance__c'
  self.primary_key = 'sfid'
end
