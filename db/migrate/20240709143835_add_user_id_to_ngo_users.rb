class AddUserIdToNgoUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :ngo_users, :user_id, :integer
  end
end
