class CreateUsers < ActiveRecord::Migration
  def change

    create_table :users do |t|
			t.string :user_name, default: ''
			t.string :first_name, default: ''
			t.string :last_name, default: ''
			t.string :email, default: ''
			t.string :phone_number, default: ''
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
