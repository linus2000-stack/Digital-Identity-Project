Given(/^I am on the "([^"]*)" page$/) do |page|
  visit path_to(page)
end

When(/^I press the "([^"]*)" button$/) do |button|
  puts button
  Capybara.default_max_wait_time = 10
  if has_button?(button)
    click_button(button)
  elsif has_link?(button)
    click_link(button)
  elsif has_css?("[aria_label='#{button}']")
    find("[aria_label='#{button}']").click
  elsif has_css?('.chat-button.big-chat-button#bigchatbutton', text: button)
    find('.chat-button.big-chat-button#bigchatbutton', text: button).click
  else
    raise "No button or link found with name '#{button}'"
  end
end

Given('I click the edit icon link') do
  find('a.edit-link-right-align.edit-icon-link[aria-label="Edit"]').click
end

Then(/^I should be directed to the "([^"]*)" page$/) do |page|
  expected_path = case page
                  when 'Upload Document'
                    new_user_particular_document_path(@user_particular)
                  when 'Contact NGO'
                    contact_ngo_path(@user_particular)
                  else
                    path_to(page)
                  end
  expect(current_path).to eq(expected_path)
end

Then(/^I should see "([^"]*)"$/) do |name|
  expect(page).to have_content(name, wait: 5)
end

Then(/^I should not see "([^"]*)"$/) do |name|
  expect(page).to have_no_content(name, wait: 5)
end

Then(/^I should see the following filled-in details$/) do |table|
  table.hashes.each do |row|
    field = row['Field']
    value = row['Value']
    expect(page).to have_content(value, wait: 10)
  end
end

Then(/^I should enter the "Home" page$/) do
  expect(current_path).to eq('/')
end

Then(/^I should stay on the "([^"]*)" page$/) do |page_name|
  expect(current_path).to eq(path_to(page_name))
end

Then(/^I should be redirected to the "([^"]*)" page$/) do |page_name|
  expect(current_path).to eq(path_to(page_name))
end

When(/^I fill in the following fields$/) do |table|
  fill_in_form(table)
end

# Additional helper methods

# Fills in a form based on the given table data
def fill_in_form(table)
  table.hashes.each do |row|
    case row['Field'].downcase
    when 'password'
      fill_in 'Password', with: row['Value'], match: :prefer_exact
    when 'country of origin'
      select row['Value'], from: row['Field']
    when 'ethnicity', 'religion', 'gender'
      # For dropdown fields
      select row['Value'], from: "#{row['Field'].downcase}_select"
    when 'date of birth', 'date of arrival in malaysia'
      # For HTML5 date fields, ensure the date is in 'YYYY-MM-DD' format
      fill_in row['Field'], with: row['Value'].to_date.strftime('%d-%m-%Y') unless row['Value'].to_s.strip.empty?
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

Given(/^that a User account by the Username of "user1", Email of "user1@mail.com", Phone Number of "90000001" exist$/) do
  user = User.find_by(username: 'user1', email: 'user1@gmail.com', phone_number: '90000001')
  expect(user).to be_persisted
end

# Maps page names to their corresponding paths
def path_to(page_name)
  user_id = if defined?(@user_particular) && @user_particular.present?
              @user_particular.id
            else
              (UserParticular.last.id + 1) # Fallback to the most recent UserParticular if @user_particular is not set
            end
  case page_name.downcase
  when 'home'
    user_particular_path(user_id)
  when 'login'
    new_user_session_path
  when 'upload document'
    new_user_particular_document_path(user_id) # Ensure this matches your route helper
  when 'ngogebirah'
    ngo_gebirah_path
  when 'user verification'
    user_verification_path
  when 'fill in particulars'
    new_user_particular_path
  when 'registration'
    new_user_registration_path
  when 'saved post'
    saved_post_user_particular_path(user_id)
  when 'search for services'
    contact_ngo_path(user_id)
  else
    raise "Undefined page: #{page_name}"
  end
end
