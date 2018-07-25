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
#  student_name__c           :string(255)
#  student_id__c             :string(18)
#

class AttendanceSerializer < ActiveModel::Serializer
  attributes :id, :start_date__c, :attendance_type__c, :notes__c, :participant_enrollment__c, :student_name__c, :student_id__c
end
