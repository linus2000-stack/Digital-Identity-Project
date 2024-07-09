# frozen_string_literal: true

# Helper Methods
# Fills in a form based on the given table data
def fill_in_form(table)
  table.hashes.each do |row|
    case row['Field'].downcase
    when 'ethnicity', 'religion', 'gender', 'country of origin'
      # For dropdown fields
      select row['Value'], from: row['Field']
    when 'date of birth', 'date of arrival in malaysia'
      # For HTML5 date fields, ensure the date is in 'YYYY-MM-DD' format
      fill_in row['Field'], with: row['Value'].to_date.strftime('%Y-%m-%d')
    else
      # For regular input fields
      fill_in row['Field'], with: row['Value']
    end
  end
end

# Verifies form data based on the given table data
def verify_form_data(table)
  table.hashes.each do |row|
    field = find_field(row['Field'])
    expect(field.value).to eq row['Value']
  end
end

# Maps page names to their corresponding paths
def path_to(page_name)
  case page_name.downcase
  when 'home'
    root_path
  when 'login'
    new_user_session_path
  when 'ngogebirah'
    ngo_gebirah_path
  when 'user verification'
    user_verification_path
  when 'fill in particulars'
    new_user_particular_path
  else
    raise "Undefined page: #{page_name}"
  end
end

# Step Definitions
# Step to fill in a form with the given table data
Given(/^I fill in the following:$/) do |table|
  fill_in_form(table)
end

# Step to check for an error message
Then(/^I will see an error message "(.+)"$/) do |message|
  expect(page).to have_content(message)
end

# Step to verify form data with the given table data
Then(/^I should see the following fields in the Digital ID:$/) do |table|
  verify_form_data(table)
end

# Step to fill in a specific field with a value
When(/^I fill in the "([^"]*)" field with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

# Step to leave a specific field empty
And(/^I leave the "([^"]*)" field empty$/) do |field|
  fill_in field, with: ''
end

# Step to check for a welcome message
Then(/^I will see a welcome message "(.+)"$/) do |message|
  expect(page).to have_content(message)
end

# Step to fill in particulars with the given table data
Given(/^I entered the following particulars:$/) do |table|
  fill_in_form(table)
end

# Step to leave the date of birth field empty
And(/^I do not enter a date of birth$/) do
  fill_in 'Date of Birth', with: ''
end

# Step to leave the country of origin field unselected
And(/^I do not select a country of origin$/) do
  select '', from: 'Country of Origin'
end

# Step to check for specific fields on the page
Then(/^I should see the following fields:$/) do |table|
  puts "Current URL: #{current_url}"
  puts "Current Path: #{current_path}"
  table.hashes.each do |row|
    expect(page).to have_content(row['Value'])
  end
end

# Step to navigate to a specific page
Given(/^I am on the "([^"]*)" page$/) do |page|
  visit path_to(page)
end

# Step to click a specific button
And(/^I press the "([^"]*)" button$/) do |button|
  click_button button
end

# Step to log in as a user
Given('I am a logged-in user') do
  @user = create(:user)
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
  expect(page).to have_content('Signed in successfully.')
end

# Additional steps for the new feature file
# Step to navigate to the login page
Given(/^I am on the "Login" page$/) do
  visit path_to('login')
end

# Step to fill in the login details
Given(/^I enter the following details on the (phone number|email|username) login page:$/) do |login_type, table|
  details = table.hashes.first
  case login_type
  when 'phone number'
    fill_in 'Phone Number', with: details['Phone Number']
  when 'email'
    fill_in 'Email', with: details['Email']
  when 'username'
    fill_in 'Username', with: details['Username']
  end
  fill_in 'Password', with: details['Password']
end

# Step to enter the login details in a simplified way
When(/^I enter the following login details:$/) do |table|
  details = table.hashes.first
  fill_in 'Phone Number', with: details['Phone Number'] if details['Phone Number']
  fill_in 'Email', with: details['Email'] if details['Email']
  fill_in 'Username', with: details['Username'] if details['Username']
  fill_in 'Password', with: details['Password']
end

# Step to click the login button
When(/^I press "Login"$/) do
  click_button 'Login'
end

# Step to check for redirection to the home page
Then(/^I should be redirected to the home page$/) do
  expect(current_path).to eq(root_path)
end

# Step to click the "I am a NGO" button
When(/^I press the "(.*)" button$/) do |button_text|
  click_button button_text
end

Given(/^I am on the "([^"]*)" page$/) do |page_name|
  visit path_to(page_name)
end

When(/^I press the "([^"]*)" button$/) do |button_text|
  click_button(button_text)
end

# Step to check for NGO buttons on the page
Then(/^I should see a set of different NGO buttons$/) do
  expect(page).to have_selector(:link_or_button, /NGO Gebirah/)
end

# Step to click the "NGO Gebirah" button
When(/^I press the "(.*?)" button$/) do |button_text|
  click_button(button_text)
end

# Step to check for redirection to the NGO: Gebirah page
Then(/^I should be redirected to the "(.*?)" page$/) do |page_name|
  expect(current_path).to eq(path_to(page_name.downcase))
end


# Step to check for a welcome message on the NGO: Gebirah page
And(/^I should see "(.*)"$/) do |welcome_message|
  expect(page).to have_content(welcome_message)
end


# Step to navigate to the NGO: Gebirah page
Given(/^I am already on my "NGO: (.*)" page$/) do |ngo_page|
  visit path_to("ngo#{ngo_page.downcase}")
end


# Step to fill in the EnableID number field
When(/^I key in the undocumented user's unique EnableID number: (\d+)$/) do |enableid|
  fill_in 'EnableID number', with: enableid
end

# Step to fill in the 6 digit code field
And(/^I key in a 6 digit code that is seen on his\/her EnableID: (\d+)$/) do |code|
  fill_in '6 digit code', with: code
end

# Step to click the Enter button
And(/^I press "Enter"$/) do
  click_button 'Enter'
end

# Step to check for redirection to the User Verification page
Then(/^I should be redirected to the "(.+)" page$/) do |page_name|
  expect(current_path).to eq(path_to(page_name.downcase.gsub(' ', '_')))
end

# Step to check for the EnableID Card on the User Verification page
And(/^I should see his\/her "(.+)"$/) do |card_name|
  expect(page).to have_content(card_name)
end

# Step to check for verification guidelines on the User Verification page
And(/^I should see a set of guidelines to properly verify an (.+)$/) do |user_type|
  expect(page).to have_content("guidelines to properly verify an #{user_type}")
end

# Step to check for the Verify button on the User Verification page
And(/^I should see a "(.+)" Button$/) do |button_text|
  expect(page).to have_selector(:link_or_button, button_text.downcase)
end

# Step to click the Verify button
When(/^I press the "(.*)" button$/) do |button_text|
  click_button button_text
end

# Step to check for a success message after verification
Then(/^I should see "Successfully verified EnableID: (\d+)!"$/) do |enableid|
  expect(page).to have_content("Successfully verified EnableID: #{enableid}!")
end

# Step to log in as a specific user by EnableID
Given(/^that I am logged into user (\d+) EnableID account$/) do |enableid|
  log_in_as_enableid_user(enableid)
end

# Step to check for a verified checkmark on the EnableID card
Then(/^I should see the checkmark on the user's EnableID card$/) do
  expect(page).to have_selector('.verified-checkmark')
end

# Step to check for verification message on the EnableID card
And(/^I should see "EnableID - verified by NGO: (.*)"$/) do |ngo_name|
  expect(page).to have_content("EnableID - verified by NGO: #{ngo_name}")
end

# Step to check for the date of verification on the EnableID card
And(/^I should see "Date of verification: #{Date.today.strftime('%Y-%m-%d')}"$/) do
  expect(page).to have_content("Date of verification: #{Date.today.strftime('%Y-%m-%d')}")
end

# New steps for handling incorrect login attempts
# Step to check for an error message on the login page
Then(/^I should see an error message "(.+)"$/) do |message|
  expect(page).to have_content(message)
end

# Step to check for the empty login page
Then(/^I should see the empty login page again$/) do
  expect(page).to have_current_path(new_user_session_path)
end

# Step to enter login details (simplified)
When(/^I enter the following login details:$/) do |table|
  details = table.hashes.first
  fill_in 'Phone Number', with: details['Phone Number'] if details['Phone Number']
  fill_in 'Email', with: details['Email'] if details['Email']
  fill_in 'Username', with: details['Username'] if details['Username']
  fill_in 'Password', with: details['Password']
end

# Step to navigate to the login page
Given(/^I am on the login page$/) do
  visit new_user_session_path
end

# New steps for handling account lockout period
Given(/^my account is locked due to multiple failed login attempts$/) do
  # Add logic to lock the account
end

When(/^I wait for the lockout period to end$/) do
  # Add logic to wait for the lockout period to end
end

Given(/^I enter the following correct password:$/) do |table|
  details = table.hashes.first
  fill_in 'Phone Number', with: details['Phone Number']
  fill_in 'Password', with: details['Password']
end

# Step to register with the following details
Given(/^I have registered with the following details:$/) do |table|
  details = table.hashes.first
  fill_in 'Phone Number', with: details['Phone Number']
  fill_in 'Password', with: details['Password']
  click_button 'Register'
end

# Step to enter the password incorrectly three times
When(/^I enter the password incorrectly three times:$/) do |table|
  details = table.hashes.first
  3.times do
    fill_in 'Phone Number', with: details['Phone Number']
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Login'
  end
end

# New steps to handle the undefined steps
When('I click {string}') do |link_text|
  click_link(link_text)
end

Then('I should be redirected to the {string} page') do |page_name|
  expect(current_path).to eq(path_to(page_name.downcase))
end

Then('I should see a form to enter my phone number or email') do
  expect(page).to have_selector('input[name="phone_number"], input[name="email"]')
end

Then('I should see the empty login page') do
  expect(page).to have_current_path(new_user_session_path)
end
