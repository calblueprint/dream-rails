# == Schema Information
#
# Table name: courses
#
#  id              :integer          not null, primary key
#  title           :string
#  is_active       :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  start_date      :datetime
#  end_date        :datetime
#  teacher_id1     :string
#  teacher_id2     :string
#  course_nickname :string
#  site            :string
#  program         :integer
#  notes           :string
#

class Course < ApplicationRecord
	enum program: {'Young Stars': 0, 'Montessori': 1, 'Summer Camp': 2, 'A Ganar': 3, 'Music': 4, 'Other': 5}
  has_many :courses_students, :dependent => :destroy
  has_many :students, :through => :courses_students
  has_many :attendances, :through => :courses_students
  has_and_belongs_to_many :teachers
  has_many :sessions, dependent: :destroy
  self.table_name = 'salesforce.class__c'

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
