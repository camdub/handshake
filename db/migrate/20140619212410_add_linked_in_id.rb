class AddLinkedInId < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_id, :string, default: ''
  end
end
