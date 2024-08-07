# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_10_122655) do
  create_table "ngo_users", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_particulars", force: :cascade do |t|
    t.string "full_name"
    t.string "phone_number_country_code"
    t.string "phone_number"
    t.string "full_phone_number"
    t.string "secondary_phone_number_country_code"
    t.string "secondary_phone_number"
    t.string "full_secondary_phone_number"
    t.string "country_of_origin"
    t.string "ethnicity"
    t.string "religion"
    t.string "gender"
    t.date "date_of_birth"
    t.date "date_of_arrival"
    t.string "photo_url"
    t.string "birth_certificate_url"
    t.string "passport_url"
    t.string "verifier_ngo"
    t.integer "unique_id", limit: 4
    t.integer "two_fa_passcode", limit: 3
    t.string "status"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unique_id"], name: "index_user_particulars_on_unique_id", unique: true
    t.index ["user_id"], name: "index_user_particulars_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "user_particulars", "users"
end
