# Step definitions for login.feature

Given(/^I enter the following details on the (phone number|email|username) login page:$/) do |login_type, table|
  data = table.rows_hash
  case login_type
  when 'phone number'
    fill_in 'user_phone_number', with: data['Value']
  when 'email'
    fill_in 'user_email', with: data['Value']
  when 'username'
    fill_in 'user_username', with: data['Value']
  end
  fill_in 'user_password', with: data['Password']
end

Given(/^I am on the login page$/) do
  visit login_path
end

When(/^I press "([^"]*)"$/) do |button|
  click_button button
end

Then(/^I should be redirected to the home page$/) do
  expect(page).to have_current_path(home_path)
end

Then(/^I should see an error message "([^"]*)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I should see the empty login page again$/) do
  expect(page).to have_current_path(login_path)
end

Then(/^I should see an error message "Phone number cannot be blank"$/) do
  expect(page).to have_content("Phone number cannot be blank")
end

Then(/^I should see an error message "Password cannot be blank"$/) do
  expect(page).to have_content("Password cannot be blank")
end

Given(/^I am on the "Login" page$/) do
  visit login_path
end

When(/^I click "Forgot password\?"$/) do
  click_link 'Forgot password?'
end

Then(/^I should be redirected to the "Reset Password" page$/) do
  expect(page).to have_current_path(reset_password_path)
end

Then(/^I should see a form to enter my phone number or email$/) do
  expect(page).to have_selector("form input[name='user[phone_number]']")
  expect(page).to have_selector("form input[name='user[email]']")
end

Given(/^I have registered with the following details:$/) do |table|
  data = table.rows_hash
  User.create!(phone_number: data['Phone Number'], password: data['Password'], email: data['Email'], username: data['Username'])
end

When(/^I enter the password incorrectly three times:$/) do |table|
  data = table.rows_hash
  3.times do
    fill_in 'user_phone_number', with: data['Phone Number']
    fill_in 'user_password', with: 'wrongpassword'
    click_button 'Login'
  end
end

Then(/^I should see an error message "Your account is locked due to multiple failed login attempts. Please try again later."$/) do
  expect(page).to have_content("Your account is locked due to multiple failed login attempts. Please try again later.")
end

Then(/^I should see the empty login page$/) do
  expect(page).to have_current_path(login_path)
end

When(/^I enter the following details:$/) do |table|
  data = table.rows_hash
  fill_in 'user_phone_number', with: data['Phone Number'] if data['Phone Number']
  fill_in 'user_email', with: data['Email'] if data['Email']
  fill_in 'user_username', with: data['Username'] if data['Username']
  fill_in 'user_password', with: data['Password']
end

Given(/^my account is locked due to multiple failed login attempts$/) do
  user = User.find_by(phone_number: '98765432')
  user.update!(locked: true) if user
end

When(/^I wait for the lockout period to end$/) do
  # Simulate waiting for the lockout period to end
  sleep(1)
end

When(/^I enter the following correct password:$/) do |table|
  data = table.rows_hash
  fill_in 'user_phone_number', with: data['Phone Number']
  fill_in 'user_password', with: data['Password']
end
