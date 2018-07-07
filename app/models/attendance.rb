# == Schema Information
#
# Table name: salesforce.attendance__c
#
#  createddate               :datetime
#  isdeleted                 :boolean
#  name                      :string(80)
#  systemmodstamp            :datetime
#  end_date__c               :date
#  participant_enrollment__c :string(18)
#  start_date__c             :date
#  sfid                      :string(18)       primary key
#  id                        :integer          not null
#  _hc_lastop                :string(32)
#  _hc_err                   :text
#  notes__c                  :string(255)
#  attendance_type__c        :float
#

class Attendance < ApplicationRecord
	enum program: {'Present': 0, 'Unexcused Absent': 1, 'Excused Absent': 2, 'Unexcused Late': 3, 'Excused Late': 4}
  belongs_to :courses_student, foreign_key: 'sfid'
	delegate :class__c, :student__c, to: :courses_student
	self.table_name = 'salesforce.attendance__c'
  self.primary_key = 'sfid'
end
