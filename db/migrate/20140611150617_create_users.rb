class CreateUsers < ActiveRecord::Migration
  def change

    create_table :users do |t|
			t.string :user_name
			t.string :first_name
			t.string :last_name
			t.string :email
			t.string :phone_number
			t.string :password
			t.string :handshake_access_token
			t.string :linkedin_access_token
			t.decimal :current_latitude
			t.decimal :current_logitude
			t.datetime :last_login_timestamp  
			
      t.timestamps
    end

    add_index(:users, :id)
    add_index(:users, :email)
  end
end
