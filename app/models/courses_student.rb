# == Schema Information
#
# Table name: courses_students
#
#  id         :integer          not null, primary key
#  student_id :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CoursesStudent < ApplicationRecord
  belongs_to :student
  belongs_to :course
  has_many :attendances, :dependent => :destroy
  self.table_name = 'salesforce.participantenrollment__c'

  #PG to Salesforce Mappings
	# def student_id
	# 	return 'salesforce.student__c'
	# end

	# def course_id
	# 	return 'salesforce.class__c'
	# end
end
