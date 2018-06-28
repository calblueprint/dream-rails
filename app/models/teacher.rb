# == Schema Information
#
# Table name: salesforce.teacher__c
#
#  email__c          :string(80)       primary key
#  first_name__c     :string(80)
#  name              :string(80)
#  last_name__c      :string(80)
#  isdeleted         :boolean
#  systemmodstamp    :datetime
#  createddate       :datetime
#  phone_number_1__c :string(40)
#  sfid              :string(18)
#  id                :integer          not null
#  _hc_lastop        :string(32)
#  _hc_err           :text
#

class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :courses_teachers
  has_many :courses, through: :courses_teachers
  belongs_to :user, optional: true

	validates :first_name, :last_name, :email, :phone, presence: true
	self.primary_key = 'email__c'
	self.table_name = 'salesforce.teacher__c'

	#PG to Salesforce Mappings

	def first_name
		return 'salesforce.first_name__c'
	end

	def last_name
		return 'salesforce.last_name__c'
	end

	def email
		return 'salesforce.email__c'
	end

	def phone
		return 'salesforce.phone_number_1__c'
	end

end
