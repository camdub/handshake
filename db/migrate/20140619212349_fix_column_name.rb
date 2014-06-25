class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :current_logitude, :current_longitude
  end
end
