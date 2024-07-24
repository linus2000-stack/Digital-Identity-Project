Then(/^I should see "([^"]*)"$/) do |name|
  expect(page).to have_content("#{name}")
end

When(/^I press the "([^"]*)" button$/) do |btn_name|
  if has_button?(btn_name)
    click_button(btn_name)
  elsif has_link?(btn_name)
    click_link(btn_name)
  else
    raise "No button or link found with name '#{btn_name}'"
  end
end

# Step to navigate to a specific page
Given(/^I am on the "([^"]*)" page$/) do |page|
  puts "Current URL: #{current_url}"
  visit path_to(page)
  puts "Current URL: #{current_url}"
end

When(/^I fill in the following fields$/) do |table|
  fill_in_form(table)
end
# Helper Methods

# Fills in a form based on the given table data
def fill_in_form(table)
  table.hashes.each do |row|
    case row['Field'].downcase
    when row['Field'] == 'Password'
      fill_in 'Password', with: row['Value'], match: :prefer_exact
    when 'country of origin'
      select row['Value'], from: row['Field']
    when 'ethnicity', 'religion', 'gender'
      # For dropdown fields
      select row['Value'], from: "#{row['Field'].downcase}_select"
    when 'date of birth', 'date of arrival in malaysia'
      # For HTML5 date fields, ensure the date is in 'YYYY-MM-DD' format
      fill_in row['Field'], with: row['Value'].to_date.strftime('%d-%m-%Y')
      # For regular input fields
    when 'phone number'
      select('+65', from: 'country_code_select') # Selects the country code from the dropdown
      fill_in 'phone_number_field', with: row['Value'] # Fills in the phone number field
    when 'secondary phone number'
      select('+65', from: 'country_code_select_secondary') # Selects the country code from the dropdown
      fill_in 'phone_number_field_secondary', with: row['Value'] # Fills in the phone number field
    else
      fill_in row['Field'], with: row['Value']
    end
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