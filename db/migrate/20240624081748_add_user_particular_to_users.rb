class AddUserParticularToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :user_particulars, foreign_key: true
  end
end
