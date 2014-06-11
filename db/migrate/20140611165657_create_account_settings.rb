class CreateAccountSettings < ActiveRecord::Migration
  def change
    create_table :account_settings do |t|
    	t.references :user, index: true
    	t.references :setting, index: true
    	t.boolean :enabled
    	
      t.timestamps
    end
  end
end
