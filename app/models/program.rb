# == Schema Information
#
# Table name: salesforce.program__c
#
#  createddate    :datetime
#  isdeleted      :boolean
#  name           :string(80)
#  systemmodstamp :datetime
#  sfid           :string(18)
#  id             :integer          not null, primary key
#  _hc_lastop     :string(32)
#  _hc_err        :text
#

class Program < ApplicationRecord
	belongs_to :course
	self.table_name = 'salesforce.program__c'
end
