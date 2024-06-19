class CreateUserParticulars < ActiveRecord::Migration[7.1]
  def change
    create_table :user_particulars do |t|
      t.string :full_name
      t.string :phone_number
      t.string :secondary_phone_number
      t.string :country_of_origin
      t.string :ethnicity
      t.string :religion 
      t.string :gender 
      t.string :date_of_birth
      t.string :date_of_arrival
      t.string :photo_url
      t.string :birth_certificate_url
      t.string :passport_url
      t.timestamps
    end
  end
end
