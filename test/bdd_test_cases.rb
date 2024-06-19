# Account Registration Step Definitions

# Step definition for navigating to the signup page
Given("I am on the signup page") do
  visit new_user_registration_path
end

# Step definition for clicking the register button
When("I press the register button") do
  click_button 'Sign up'
end

# Step definition for verifying the confirmation message
Then("I will see a confirmation message {string}") do |message|
  expect(page).to have_content(message)
end

# Step definition for verifying redirection to the login page
Then("I will be redirected to the login page") do
  expect(page).to have_current_path(new_user_session_path)
end

# Step definition for verifying error messages
Then("I will see an error message {string}") do |message|
  expect(page).to have_content(message)
end

# Step definition for verifying that the user remains on the signup page
Then("I will remain on the signup page") do
  expect(page).to have_current_path(user_registration_path)
end

# Step definition for filling in the registration form correctly
Given("I fill in the username, email, phone number, password, and confirm password fields correctly") do
  fill_in 'Username', with: 'testuser'
  fill_in 'Email', with: 'testuser@example.com'
  fill_in 'Phone number', with: '1234567890'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'password123'
end

# Step definition for missing username field
Given("I do not fill in the username field") do
  fill_in 'Email', with: 'testuser@example.com'
  fill_in 'Phone number', with: '1234567890'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'password123'
end

# Step definition for using an existing username
Given("I fill in a username that already exists, email, phone number, password, and confirm password fields correctly") do
  User.create!(username: 'existinguser', email: 'existinguser@example.com', password: 'password123', phone_number: '1234567890')
  fill_in 'Username', with: 'existinguser'
  fill_in 'Email', with: 'newemail@example.com'
  fill_in 'Phone number', with: '1234567890'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'password123'
end

# Step definition for password mismatch
Given("the confirm password field does not match the password field") do
  fill_in 'Username', with: 'testuser'
  fill_in 'Email', with: 'testuser@example.com'
  fill_in 'Phone number', with: '1234567890'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'differentpassword'
end

# Step definition for invalid email format
Given("I fill in the username, email with an invalid format, phone number, password, and confirm password fields correctly") do
  fill_in 'Username', with: 'testuser'
  fill_in 'Email', with: 'invalid-email-format'
  fill_in 'Phone number', with: '1234567890'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'password123'
end

# User Login Step Definitions

# Step definition for navigating to the login page
Given("I am on the login page") do
  visit new_user_session_path
end

# Step definition for clicking the login button
When("I press the login button") do
  click_button 'Log in'
end

# Step definition for verifying successful login and redirection to dashboard
Then("I will be logged in successfully") do
  expect(page).to have_current_path(account_dashboard_path)
end

# Step definition for verifying welcome message
Then("I will see a welcome message {string}") do |message|
  expect(page).to have_content(message)
end

# Step definition for verifying error messages
Then("I will see an error message {string}") do |message|
  expect(page).to have_content(message)
end

# Step definition for verifying that the user remains on the login page
Then("I will remain on the login page") do
  expect(page).to have_current_path(new_user_session_path)
end

# Step definition for filling in the username field
Given("I fill in the username field with {string}") do |username|
  fill_in 'Username', with: username
end

# Step definition for filling in the password field
Given("I fill in the password field with {string}") do |password|
  fill_in 'Password', with: password
end

# Step definition for leaving the username field empty
Given("I leave the username field empty") do
  fill_in 'Username', with: ''
end
