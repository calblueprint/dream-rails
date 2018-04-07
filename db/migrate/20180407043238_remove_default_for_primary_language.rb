class RemoveDefaultForPrimaryLanguage < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :students, :primary_language, nil
  end
end
