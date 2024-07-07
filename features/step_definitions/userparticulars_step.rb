# Step definitions for login.feature

Given(/^I enter the following details on the (phone number|email|username) login page:$/) do |login_type, table|
  data = table.rows_hash
  case login_type
  when 'phone number'
    fill_in 'Phone Number', with: data['Phone Number']
  when 'email'
    fill_in 'Email', with: data['Email']
  when 'username'
    fill_in 'Username', with: data['Username']
  end
  fill_in 'Password', with: data['Password']
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
  expect(page).to have_selector("form input[name='phone_number']")
  expect(page).to have_selector("form input[name='email']")
end

Given(/^I have registered with the following details:$/) do |table|
  data = table.rows_hash
  User.create!(phone_number: data['Phone Number'], password: data['Password'])
end

When(/^I enter the password incorrectly three times:$/) do |table|
  data = table.rows_hash
  3.times do
    fill_in 'Phone Number', with: data['Phone Number']
    fill_in 'Password', with: data['Password']
    click_button 'Login'
  end
end

Then(/^I should see the empty login page$/) do
  expect(page).to have_current_path(login_path)
end

Given(/^my account is locked due to multiple failed login attempts$/) do
  # Assuming the user model has a field `locked` to indicate account lock status
  user = User.find_by(phone_number: '98765432')
  user.update!(locked: true) if user
end

When(/^I wait for the lockout period to end$/) do
  # Simulate waiting for lockout period to end
  sleep(1)
end

When(/^I enter the following correct password:$/) do |table|
  data = table.rows_hash
  fill_in 'Phone Number', with: data['Phone Number']
  fill_in 'Password', with: data['Password']
end

# Step definitions for reset_password.feature

Given(/^I am on the reset password page$/) do
  visit reset_password_path
end

When(/^I enter my (phone number|email|username)$/) do |type|
  case type
  when 'phone number'
    fill_in 'Phone Number', with: '98765432'
  when 'email'
    fill_in 'Email', with: 'user@example.com'
  when 'username'
    fill_in 'Username', with: 'user123'
  end
end

Then(/^I should receive an (SMS|email) with a reset link$/) do |method|
  if method == 'SMS'
    expect(page).to have_content("An SMS with a reset link has been sent")
  else
    expect(page).to have_content("An email with a reset link has been sent")
  end
end

# Step definitions for sign_up.feature

Given(/^I am on the sign-up page$/) do
  visit sign_up_path
end

When(/^I enter the following details:$/) do |table|
  data = table.rows_hash
  fill_in 'Username', with: data['Username']
  fill_in 'Email', with: data['Email']
  fill_in 'Phone Number', with: data['Phone Number']
  fill_in 'Password', with: data['Password']
  fill_in 'Confirm Password', with: data['Confirm Password']
end

Then(/^I should see a welcome message$/) do
  expect(page).to have_content("Welcome!")
end

Then(/^I should be redirected to the home page$/) do
  expect(page).to have_current_path(home_path)
end

Then(/^I should see an error message "Passwords do not match"$/) do
  expect(page).to have_content("Passwords do not match")
end

Then(/^I should see an error message "Email already registered"$/) do
  expect(page).to have_content("Email already registered")
end

# Step definitions for confirm_user_particular.feature

Given(/^I am on the "Fill in Particulars" page$/) do
  visit fill_in_particulars_path
end

Given(/^I entered the following particulars:$/) do |table|
  data = table.rows_hash
  fill_in 'Full Name', with: data['Full Name']
  fill_in 'Phone Number', with: data['Phone Number']
  fill_in 'Secondary Phone Number', with: data['Secondary Phone Number']
  fill_in 'Country of Origin', with: data['Country of Origin']
  fill_in 'Ethnicity', with: data['Ethnicity']
  fill_in 'Religion', with: data['Religion']
  fill_in 'Gender', with: data['Gender']
  fill_in 'Date of Birth', with: data['Date of Birth']
  fill_in 'Date of Arrival in Malaysia', with: data['Date of Arrival in Malaysia']
end

Then(/^I should see the filled-in details:$/) do |table|
  data = table.rows_hash
  expect(page).to have_field('Full Name', with: data['Full Name'])
  expect(page).to have_field('Phone Number', with: data['Phone Number'])
  expect(page).to have_field('Secondary Phone Number', with: data['Secondary Phone Number'])
  expect(page).to have_field('Country of Origin', with: data['Country of Origin'])
  expect(page).to have_field('Ethnicity', with: data['Ethnicity'])
  expect(page).to have_field('Religion', with: data['Religion'])
  expect(page).to have_field('Gender', with: data['Gender'])
  expect(page).to have_field('Date of Birth', with: data['Date of Birth'])
  expect(page).to have_field('Date of Arrival in Malaysia', with: data['Date of Arrival in Malaysia'])
end

# Step definitions for fill_user_particular_form.feature

Given(/^I am on the "Enter Particulars" page$/) do
  visit enter_particulars_path
end

When(/^I press "Submit"$/) do
  click_button 'Submit'
end

Then(/^I should see the message "Particulars submitted successfully"$/) do
  expect(page).to have_content("Particulars submitted successfully")
end

Then(/^I should be redirected to the "Confirm Particulars" page$/) do
  expect(page).to have_current_path(confirm_particulars_path)
end

Then(/^I should see the error message "Full Name is required"$/) do
  expect(page).to have_content("Full Name is required")
end

# Step definitions for ngo_verify_user.feature

Given(/^I am logged in as an NGO representative$/) do
  visit ngo_login_path
  fill_in 'Username', with: 'ngo_rep'
  fill_in 'Password', with: 'password'
  click_button 'Login'
end

Given(/^I have the user's Digital ID$/) do
  @digital_id = '123456'
end

When(/^I enter the Digital ID into the system$/) do
  fill_in 'Digital ID', with: @digital_id
end

When(/^I press "Verify"$/) do
  click_button 'Verify'
end

Then(/^I should see the message "User verified successfully"$/) do
  expect(page).to have_content("User verified successfully")
end

Then(/^the user's status should be updated to "Verified"$/) do
  user = User.find_by(digital_id: @digital_id)
  expect(user.status).to eq("Verified")
end

When(/^I enter an invalid Digital ID into the system$/) do
  fill_in 'Digital ID', with: 'invalid_id'
end

Then(/^I should see the error message "Invalid Digital ID"$/) do
  expect(page).to have_content("Invalid Digital ID")
end

# Step definitions for start_user_particular.feature

Given(/^I am on the “Home” page$/) do
  visit home_path
end

When(/^I press "Fill in your particulars to get your Digital ID!"$/) do
  click_button 'Fill in your particulars to get your Digital ID!'
end

Then(/^I should be redirected to the "Enter Particulars” page$/) do
  expect(page).to have_current_path(enter_particulars_path)
end

Then(/^I should see "Fill in your particulars"$/) do
  expect(page).to have_content("Fill in your particulars")
end
