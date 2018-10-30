# == Schema Information
#
# Table name: salesforce.student__c
#
#  tipo_de_documento__c       :string(4099)
#  notes__c                   :string(255)
#  contacto_primario_name__c  :string(255)
#  nationality__c             :string(255)
#  contacto_primario_phone__c :string(255)
#  email__c                   :string(80)
#  first_name__c              :string(50)
#  name                       :string(80)
#  lastmodifieddate           :datetime
#  last_name__c               :string(50)
#  isdeleted                  :boolean
#  systemmodstamp             :datetime
#  usuario_de_facebook__c     :string(255)
#  direccion__c               :string(255)
#  nickname__c                :string(25)
#  createddate                :datetime
#  phone_number_1__c          :string(40)
#  date_of_birth__c           :date
#  sex__c                     :string(255)
#  idioma_principal__c        :string(255)
#  sfid                       :string(18)       primary key
#  id                         :integer          not null
#  _hc_lastop                 :string(32)
#  _hc_err                    :text
#  phone_number_2__c          :string(40)
#

class StudentSerializer < ActiveModel::Serializer
  attributes :id, :attendance_stats, :first_name__c, :last_name__c, :date_of_birth__c, :createddate, :lastmodifieddate, :direccion__c, :nickname__c, :contacto_primario_name__c, :contacto_primario_phone__c, :sex__c, :usuario_de_facebook__c, :notes__c, :tipo_de_documento__c, :phone_number_1__c, :phone_number_2__c, :email__c, :idioma_principal__c, :nationality__c

  def attendance_stats
      if scope.nil?
        return {num_present: 0, num_late: 0, num_absent: 0}
      end
      attendances = object.attendances.select {|a| a.class__c == scope[:class__c]}
      attendances = attendances.group_by(&:attendance_type__c)
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
