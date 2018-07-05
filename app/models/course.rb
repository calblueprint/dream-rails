# == Schema Information
#
# Table name: salesforce.class__c
#
#  notes__c         :string(255)
#  facilitator_2__c :string(18)
#  facilitator_1__c :string(18)
#  name             :string(80)
#  title__c         :string(80)
#  isdeleted        :boolean
#  systemmodstamp   :datetime
#  end_date__c      :date
#  createddate      :datetime
#  start_date__c    :date
#  program__c       :string(18)
#  sfid             :string(18)
#  id               :integer          not null, primary key
#  _hc_lastop       :string(32)
#  _hc_err          :text
#  f2_last_name__c  :string(255)
#  f1_last_name__c  :string(255)
#  f1_first_name__c :string(255)
#  f2_first_name__c :string(255)
#  f2_email__c      :string(255)
#  f1_email__c      :string(255)
#

class Course < ApplicationRecord
	enum program: {'Young Stars': 0, 'Montessori': 1, 'Summer Camp': 2, 'A Ganar': 3, 'Music': 4, 'Other': 5}
  has_many :courses_students, foreign_key: 'class__c', :dependent => :destroy
  has_many :students, :through => :courses_students
  has_many :attendances, :through => :courses_students
  has_and_belongs_to_many :teachers
  has_many :sessions, foreign_key: 'course_id', dependent: :destroy
  self.table_name = 'salesforce.class__c'
  self.primary_key = 'sfid'

  #PG to Salesforce Mappings
  def title
		return 'salesforce.name'
	end

	def start_date
		return 'salesforce.start_date__c'
	end

	def end_date
		return 'salesforce.end_date__c'
	end

	def teacher_id1
		return 'salesforce.facilitator_1__c'
	end

	def teacher_id2
		return 'salesforce.facilitator_2__c'
	end

	def site
		return 'salesforce.site__c'
	end

	def program
		return 'salesforce.program__c'
	end
end
