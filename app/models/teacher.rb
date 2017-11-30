# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  dream_id   :string
#  email      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :courses
	validates :first_name, :last_name, :dream_id, :email, :phone, presence: true
end
