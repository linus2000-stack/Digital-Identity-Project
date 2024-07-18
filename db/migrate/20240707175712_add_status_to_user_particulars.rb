class AddStatusToUserParticulars < ActiveRecord::Migration[7.1]
  def change
    add_column :user_particulars, :status, :string
  end
end
