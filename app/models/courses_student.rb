# == Schema Information
#
# Table name: salesforce.participantenrollment__c
#
#  createddate    :datetime
#  isdeleted      :boolean
#  name           :string(80)
#  systemmodstamp :datetime
#  class__c       :string(18)
#  student__c     :string(18)
#  sfid           :string(18)       primary key
#  id             :integer          not null
#  _hc_lastop     :string(32)
#  _hc_err        :text
#

class CoursesStudent < ApplicationRecord
  belongs_to :student,  foreign_key: "student__c"
  belongs_to :course, foreign_key: "class__c"
  has_many :attendances, foreign_key: "participant_enrollment__c", dependent: :destroy
  self.table_name = 'salesforce.participantenrollment__c'
  self.primary_key = 'sfid'

  #PG to Salesforce Mappings
	# def student_id
	# 	return 'salesforce.student__c'
	# end

	# def course_id
	# 	return 'salesforce.class__c'
	# end
end
