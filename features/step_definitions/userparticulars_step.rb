# frozen_string_literal: true

# Helper Methods
def fill_in_form(table)
  table.hashes.each do |row|
    fill_in row['Field'], with: row['Value']
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
    user_particular_path
  when 'fill in particulars'
    new_user_session_path
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
  table.hashes.each do |row|
    if row['Value'].nil? || row['Value'].empty?
      field = find_field(row['Field'])
      expect(field.value).to be_empty
    else
      expect(page).to have_select(row['Field'], selected: row['Value'])
    end
  end
end

Given(/^I am on the "([^"]*)" page$/) do |page|
  visit path_to(page)
end
