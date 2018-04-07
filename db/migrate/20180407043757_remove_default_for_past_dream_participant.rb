class RemoveDefaultForPastDreamParticipant < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :students, :past_dream_participant, nil
  end
end
