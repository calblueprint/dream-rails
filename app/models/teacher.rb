class Teacher < ApplicationRecord
	validates :first_name, :last_name, :dream_id, :email, :phone, presence: true
end
