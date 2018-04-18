class StudentSerializer < ActiveModel::Serializer
  attributes :id, :attendance_stats, :first_name, :last_name, :birthday, :address, :nickname, :created_at, :updated_at, :primary_contact, :primary_contact_phone, :dream_id, :is_active, :sex, :facebook_name, :notes, :document_type, :level, :phone, :phone_2, :email, :primary_language, :past_dream_participant

  def attendance_stats
      attendances = object.attendances.group_by(&:attendance_type)
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
