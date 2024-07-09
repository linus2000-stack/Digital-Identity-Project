# features/step_definitions/ngo_verification_step.rb

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
  case page_name.to_s.downcase
  when 'home'
    root_path
  when 'login'
    new_user_session_path
  when 'ngo: gebirah'
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
  expect(page).to have_content(/#{message}/)
end

# Step to verify form data with the given table data
Then(/^I should see the following fields in the Digital ID:$/) do |table|
  verify_form_data(table)
end

# Step to fill in a specific field with a value
When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

# Step to check for specific text on the page
Then(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(/#{text}/)
end

# Step to enter a specific text into a field
When(/^I key in the undocumented user's unique EnableID number: (\d+)$/) do |number|
  fill_in 'EnableID', with: number
end

# Step to press a button
And(/^I press "([^"]*)"$/) do |button|
  click_button(/#{button}/)
end

# Step to key in a code
When(/^I key in a 6 digit code that is seen on his\/her EnableID: (\d+)$/) do |code|
  fill_in '2FA Code', with: code
end

# Step to check for the presence of an element
Then(/^I should see his\/her EnableID card$/) do
  expect(page).to have_selector('#enableIDCard')
end

# Step to check for the presence of a verify button
Then(/^I should see a "Verify" button below$/) do
  expect(page).to have_button(/Verify/)
end

# Step to check for a specific message after verification
Then(/^I should see "Successfully verified EnableID: (\d+)!"$/) do |enableID|
  expect(page).to have_content(/Successfully verified EnableID: #{enableID}!/)
end

# Step to check for the verified checkmark
Then(/^I should see the checkmark on the user's EnableID card$/) do
  expect(page).to have_selector('#enableIDCard .checkmark')
end

# Step to check for the verification message and date
Then(/^I should see "EnableID - verified by NGO: Gebirah"$/) do
  expect(page).to have_content(/EnableID - verified by NGO: Gebirah/)
end

Then(/^I should see "Date of verification: (.+)"$/) do |date|
  expect(page).to have_content(/Date of verification: #{date}/)
end

# Step to navigate to a specific page
Given(/^I am on the "([^"]*)" page$/) do |page|
  visit path_to(page)
end

# Step to click a specific button
And(/^I press the "([^"]*)" button$/) do |button|
  click_button(/#{button}/)
end

# Step to log in as a user
Given('I am a logged-in user') do
  @user = create(:user)
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button(/Log in/)
  expect(page).to have_content(/Signed in successfully./)
end

# Additional steps for the new feature file
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

# Step to check for a set of different NGO buttons
Then(/^I should see a set of different NGO buttons$/) do
  expect(page).to have_selector('button.ngo-buttons')
end

# Step to check for redirection to a specific page
Then(/^I should be redirected to the "([^"]*)" page$/) do |page|
  expect(current_path).to eq path_to(page)
end

# Step to check for specific text
And(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(/#{text}/)
end
