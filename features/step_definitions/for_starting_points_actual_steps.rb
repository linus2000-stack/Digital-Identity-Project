# Brendan: Starting point for NGO show page
Given(/^I am already on my NGO "([^"]*)" page$/) do |ngo_name|
  step 'I am on the "Login" page'
  step 'I press the "I am a NGO" button'
  step %(I press the NGO "#{ngo_name}" card)
end

# Fawziyah: Starting point for User_particulars show page
Given(/^I am now on the user particulars home page$/) do
  ENV['SKIP_AUTHENTICATE_USER'] = 'true'
  login_as($user, scope: :user)
  visit root_path
  expected_path = '/'
  raise "Expected to be on #{expected_path}, but was on #{current_path}" unless current_path == expected_path

  step 'I should see "Welcome, "'
end

# Yiqing: Starting point for NGO User Verification page

Given('I am already on NGO "Gebirah" verify a user page') do
  step 'I am on the "Login" page'
  step 'I press the "I am a NGO" button'
  step 'I press the NGO "Gebirah" card'
  step 'I key in the Unique ID: \'3665753" and 6 digit code 2FA: "310263", then I press the check button'
  step 'I should be redirected to the User Verification page under "Gebirah"'
  step 'I should see his/her EnableID card'
  step 'I should see "3665753"'
  step 'I should see "Verify" button'
end
