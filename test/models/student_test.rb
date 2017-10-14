# == Schema Information
#
# Table name: students
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  address         :string
#  year            :integer
#  nickname        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  emergency_name  :string
#  phone           :string
#  emergency_phone :string
#  course_id       :integer
#  teacher_id      :integer
#  birthday        :date
#

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
