# spec/features/user_registration_spec.rb
require 'rails_helper'

RSpec.feature "User Registration", type: :feature do
  scenario "User signs up with valid details" do
    visit "/signup"
    fill_in "Username", with: "newuser"
    fill_in "Email", with: "user@example.com"
    fill_in "Phone number", with: "1234567890"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Register"

    expect(page).to have_content("Registration Successful")
    expect(current_path).to eq("/login")
  end

  scenario "User signs up with missing username" do
    visit "/signup"
    fill_in "Email", with: "user@example.com"
    fill_in "Phone number", with: "1234567890"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Register"

    expect(page).to have_content("Username is required")
    expect(current_path).to eq("/signup")
  end

  scenario "User signs up with existing username" do
    User.create(username: "existinguser", email: "existing@example.com", phone_number: "1234567890", password: "password")
    visit "/signup"
    fill_in "Username", with: "existinguser"
    fill_in "Email", with: "newuser@example.com"
    fill_in "Phone number", with: "1234567890"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Register"

    expect(page).to have_content("Username already exists")
    expect(current_path).to eq("/signup")
  end

  scenario "User signs up with password mismatch" do
    visit "/signup"
    fill_in "Username", with: "newuser"
    fill_in "Email", with: "user@example.com"
    fill_in "Phone number", with: "1234567890"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password123"
    click_button "Register"

    expect(page).to have_content("Passwords do not match")
    expect(current_path).to eq("/signup")
  end

  scenario "User signs up with invalid email format" do
    visit "/signup"
    fill_in "Username", with: "newuser"
    fill_in "Email", with: "userexample.com"
    fill_in "Phone number", with: "1234567890"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Register"

    expect(page).to have_content("Invalid email format")
    expect(current_path).to eq("/signup")
  end
end
