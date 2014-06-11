class CreateProfileTypes < ActiveRecord::Migration
  def change
    create_table :profile_types do |t|
    	t.string :connection_type
    	
      t.timestamps
    end
  end
end
