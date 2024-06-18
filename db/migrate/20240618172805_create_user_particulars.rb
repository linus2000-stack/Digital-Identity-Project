class CreateUserParticulars < ActiveRecord::Migration[7.1]
  def change
    create_table :user_particulars do |t|
      t.string :full_name
      t.string :phone_number
      t.timestamps
    end
  end
end
