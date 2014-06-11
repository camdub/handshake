class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
    	t.references :user, index: true
    	t.references :profile_type, index: true
    	t.boolean :handshake_user_name
    	t.boolean :full_name
    	t.boolean :company
    	t.boolean :title
    	t.boolean :picture
    	t.boolean :phone_number
    	
      t.timestamps
    end
  end
end
