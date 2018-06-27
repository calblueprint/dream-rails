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
#  course_id  :integer
#

class Session < ApplicationRecord
  belongs_to :course
end
