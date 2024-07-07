class AddUniqueIdToUserParticulars < ActiveRecord::Migration[7.1]
  def change
    add_column :user_particulars, :unique_id, :integer
  end
end
