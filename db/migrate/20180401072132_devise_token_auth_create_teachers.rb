class DeviseTokenAuthCreateTeachers < ActiveRecord::Migration[5.1]
  def change
    change_table(:teachers) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      # ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      # ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Tokens
      t.json :tokens

    end

    Teacher.reset_column_information
    Teacher.find_each do |u|
      u.uid = u.email
      u.provider = 'email'   # is this necessary?
      u.save!
    end

    add_index :teachers, [:uid, :provider],     unique: true
    # add_index :teachers, :confirmation_token,   unique: true
    # add_index :teachers, :unlock_token,       unique: true
  end
end
