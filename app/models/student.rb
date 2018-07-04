# == Schema Information
#
# Table name: salesforce.student__c
#
#  tipo_de_documento__c       :string(4099)
#  notes__c                   :string(255)
#  nationality__c             :string(255)
#  email__c                   :string(80)
#  first_name__c              :string(50)
#  name                       :string(80)
#  last_name__c               :string(50)
#  isdeleted                  :boolean
#  systemmodstamp             :datetime
#  usuario_de_facebook__c     :string(255)
#  direccion__c               :string(255)
#  phone_number_2__c          :string(40)
#  createddate                :datetime
#  phone_number_1__c          :string(40)
#  date_of_birth__c           :date
#  sex__c                     :string(255)
#  idioma_principal__c        :string(255)
#  sfid                       :string(18)
#  id                         :integer          not null, primary key
#  _hc_lastop                 :string(32)
#  _hc_err                    :text
#  nickname__c                :string(25)
#  contacto_primario_name__c  :string(255)
#  contacto_primario_phone__c :string(255)
#  lastmodifieddate           :datetime
#

class Student < ApplicationRecord
	enum sex: {'Female': 0, 'Male': 1}
	enum document_type: {'None': 0, 'Govt. ID card': 1, 'Passport or foreign birth certificate': 2, 
		'Regularization card': 3, 'Dominican birth certificate': 4, 'Dominican birth cetificate that says foreigner': 5}
	enum level: {'Maternal': 0, 'Kinder': 1, 'Pre-Primaria': 2, 'Primero': 3, 'Segundo': 4}
	enum primary_language: {'Spanish': 0, 'Creole': 1, 'Other': 2}
	enum is_active: {'Yes': 0, 'No': 1}, _prefix: true
	enum past_dream_participant: {'Yes': 0, 'No': 1}, _prefix: true

  has_many :courses_students
  has_many :courses, :through => :courses_students
	has_many :attendances, :through => :courses_students
  validates :first_name, :last_name, :birthday, 
  :phone, presence: true
  self.table_name = 'salesforce.student__c'
  
end
