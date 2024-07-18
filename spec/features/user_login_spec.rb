# spec/features/user_login_spec.rb
require 'rails_helper'

RSpec.feature "User Login", type: :feature do
  let!(:user) { User.create(username: "validUser", email: "user@example.com", phone_number: "1234567890", password: "validPassword") }

  scenario "User logs in with valid credentials" do
    visit "/login"
    fill_in "Username", with: "validUser"
    fill_in "Password", with: "validPassword"
    click_button "Login"

    expect(page).to have_content("Welcome validUser")
    expect(current_path).to eq("/dashboard")
  end

  scenario "User logs in with missing username" do
    visit "/login"
    fill_in "Password", with: "validPassword"
    click_button "Login"

    expect(page).to have_content("Username is required")
    expect(current_path).to eq("/login")
  end

  scenario "User logs in with incorrect credentials" do
    visit "/login"
    fill_in "Username", with: "invalidUser"
    fill_in "Password", with: "validPassword"
    click_button "Login"

    expect(page).to have_content("Incorrect username or password")
    expect(current_path).to eq("/login")
  end
end
