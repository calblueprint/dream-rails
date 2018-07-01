class Program < ApplicationRecord
	belongs_to :course
	self.table_name = 'salesforce.program__c'
end
