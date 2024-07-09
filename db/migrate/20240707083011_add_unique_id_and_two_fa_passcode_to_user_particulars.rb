class AddUniqueIdAndTwoFaPasscodeToUserParticulars < ActiveRecord::Migration[7.1]
  def change
    add_column :user_particulars, :unique_id, :integer, limit: 4
    add_column :user_particulars, :two_fa_passcode, :integer, limit: 3

    # Add a unique index to unique_id column to enforce uniqueness
    add_index :user_particulars, :unique_id, unique: true
  end
end
