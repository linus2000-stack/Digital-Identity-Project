# frozen_string_literal: true

# Helper Methods
def fill_in_form(table)
  table.hashes.each do |row|
    case row['Field'].downcase
    when 'ethnicity', 'religion', 'gender', 'country of origin'
      select row['Value'], from: row['Field']
    when 'date of birth', 'date of arrival in malaysia'
      # For HTML5 date fields, ensure the date is in 'YYYY-MM-DD' format
      fill_in row['Field'], with: row['Value'].to_date.strftime('%dd-%mm-%YYYY')
    else
      fill_in row['Field'], with: row['Value']
    end
  end
end

def verify_form_data(table)
  table.hashes.each do |row|
    field = find_field(row['Field'])
    expect(field.value).to eq row['Value']
  end
end

def path_to(page_name)
  case page_name.downcase
  when 'home'
    # Replace 'show_path' with the actual path helper for your show page
    root_path
  when 'fill in particulars'
    new_user_particular_path
  else
    raise "Undefined page: #{page_name}"
  end
end

# Step Definitions
Given(/^I fill in the following:$/) do |table|
  fill_in_form(table)
end

Then(/^I will see an error message "(.+)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I should see the following fields in the Digital ID:$/) do |table|
  verify_form_data(table)
end

When(/^I fill in the "([^"]*)" field with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

And(/^I leave the "([^"]*)" field empty$/) do |field|
  fill_in field, with: ''
end

Then(/^I will see a welcome message "(.+)"$/) do |message|
  expect(page).to have_content(message)
end

Given(/^I entered the following particulars:$/) do |table|
  fill_in_form(table)
end

And(/^I do not enter a date of birth$/) do
  fill_in 'Date of Birth', with: ''
end

And(/^I do not select a country of origin$/) do
  select '', from: 'Country of Origin' # Assuming the select dropdown has an empty option or placeholder
end

# Assuming there's a need to check for empty fields or specific dropdown selections
Then(/^I should see the following fields:$/) do |table|
  puts "Current URL: #{current_url}"
  puts "Current Path: #{current_path}"
  table.hashes.each do |row|
    expect(page).to have_content(row['Value'])
  end
end

Given(/^I am on the "([^"]*)" page$/) do |page|
  visit path_to(page)
end

And(/^I press the "([^"]*)" button$/) do |button|
  click_link(button)
end

Given('I am a logged-in user') do
  # Assuming you have a factory for user
  @user = create(:user)

  # Visit the login page. Adjust the path as necessary for your app
  visit new_user_session_path

  # Fill in the login form. Adjust field ids/names as necessary.
  fill_in 'Log in', with: @user.email
  fill_in 'Password', with: @user.password

  # Click the login button. Adjust the button value as necessary.
  click_button 'Log in'

  # Optionally, you can add an assertion here to ensure the login was successful
  expect(page).to have_content('Signed in successfully.')
end

# From here onwards User Story 2
# Additional steps for the new feature file
# Step to navigate to the login page
Given(/^I am on the “Login” page$/) do
  visit path_to('login')
end

# Step to click the "I am a NGO" button
When(/^I press the "I am a NGO" button$/) do
  click_button 'I am a NGO'
end

# Step to check for NGO buttons on the page
Then(/^I should see a set of different NGO buttons$/) do
  expect(page).to have_selector(:link_or_button, 'NGO Gebirah')
end

# Step to click the "NGO Gebirah" button
When(/^I press the "NGO Gebirah" button$/) do
  click_button 'NGO Gebirah'
end

# Step to check for redirection to the NGO: Gebirah page
Then(/^I should be redirected to the "NGO: Gebirah" page$/) do
  expect(current_path).to eq(path_to('ngogebirah'))
end

# Step to check for a welcome message on the NGO: Gebirah page
And(/^I should see "Welcome Gebirah!"$/) do
  expect(page).to have_content('Welcome Gebirah!')
end

# Step to navigate to the NGO: Gebirah page
Given(/^I am already on my "NGO: Gebirah" page$/) do
  visit path_to('ngogebirah')
end

# Step to fill in the EnableID number field
When(/^I key in the undocumented user's unique EnableID number: (\d+)$/) do |enableid|
  fill_in 'EnableID number', with: enableid
end

# Step to fill in the 6 digit code field
And(/^I key in a 6 digit code that is seen on his/her EnableID: (\d+)$/) do |code|
  fill_in '6 digit code', with: code
end

# Step to click the Enter button
And(/^I press "Enter"$/) do
  click_button 'Enter'
end

# Step to check for redirection to the User Verification page
Then(/^I should be redirected to the "User Verification" page$/) do
  expect(current_path).to eq(path_to('user verification'))
end

# Step to check for the EnableID Card on the User Verification page
And(/^I should see his/her "EnableID Card"$/) do
  expect(page).to have_content('EnableID Card')
end

# Step to check for verification guidelines on the User Verification page
And(/^I should see a set of guidelines to properly verify an EnableID user$/) do
  expect(page).to have_content('guidelines to properly verify an EnableID user')
end

# Step to check for the Verify button on the User Verification page
And(/^I should see a "Verified" Button$/) do
  expect(page).to have_selector(:link_or_button, 'Verify')
end

# Step to click the Verify button
When(/^I press the "Verify" button$/) do
  click_button 'Verify'
end

# Step to check for a success message after verification
Then(/^I should see "Successfully verified EnableID: (\d+)!"$/) do |enableid|
  expect(page).to have_content("Successfully verified EnableID: #{enableid}!")
end

# Step to log in as a specific user by EnableID
Given(/^that I am logged into user (\d+) EnableID account$/) do |enableid|
  # Assuming there's a method to log in as a specific user by their EnableID
  log_in_as_enableid_user(enableid)
end

# Step to check for a verified checkmark on the EnableID card
Then(/^I should see the checkmark on the user's EnableID card$/) do
  expect(page).to have_selector('.verified-checkmark')
end

# Step to check for verification message on the EnableID card
And(/^I should see "EnableID - verified by NGO: Gebirah"$/) do
  expect(page).to have_content('EnableID - verified by NGO: Gebirah')
end

# Step to check for the date of verification on the EnableID card
And(/^I should see "Date of verification: (today's date)"$/) do
  expect(page).to have_content("Date of verification: #{Date.today.strftime('%Y-%m-%d')}")
end
