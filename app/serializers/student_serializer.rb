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

class StudentSerializer < ActiveModel::Serializer
  attributes :id, :attendance_stats, :first_name, :last_name, :birthday, :address, :nickname, :created_at, :updated_at, :primary_contact, :primary_contact_phone, :dream_id, :is_active, :sex, :facebook_name, :notes, :document_type, :level, :phone, :phone_2, :email, :primary_language, :past_dream_participant

  def attendance_stats
      if scope.nil?
        return {num_present: 0, num_late: 0, num_absent: 0}
      end
      attendances = object.attendances.select {|a| a.course_id == scope[:course_id]}
      attendances = attendances.group_by(&:attendance_type)
      num_present = 0
      num_late = 0
      num_absent = 0
      if attendances[0]
        num_present += attendances[0].length
      end
      if attendances[1]
        num_absent += attendances[1].length
      end
      if attendances[2]
        num_absent += attendances[2].length
      end
      if attendances[3]
        num_late += attendances[3].length
      end
      if attendances[4]
        num_late += attendances[4].length
      end
      {num_present: num_present, num_late: num_late, num_absent: num_absent}
  end
end
