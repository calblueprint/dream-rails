# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  weekday    :string
#  start_time :datetime
#  end_time   :datetime
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :string
#

class Session < ApplicationRecord
  belongs_to :course
  validates :course_id, :presence => true
end
