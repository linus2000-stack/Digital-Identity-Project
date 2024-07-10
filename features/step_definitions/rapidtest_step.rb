Given('a user particular exists with unique ID {string} and 2FA code {string}') do |unique_id, two_fa_code|
  UserParticular.find_by_id(1).update(unique_id:, two_fa_passcode: two_fa_code)
  $user_particular = UserParticular.find_by_id(1)
end

Given('I am on "User Verification" page') do
  # Assuming the journey starts at the "Home" page and requires login
  step 'I am already on my NGO "Gebirah" page'

  step 'I key in the undocumented user\'s unique EnableID number: 1071783'
  step 'I key in a 6 digit code that is seen on his/her EnableID: 958523'
  step 'I press "Check" button'
end

# Step to click a specific button
And(/^I press the "([^"]*)" button$/) do |button|
  if has_link?(button)
    click_link button
  elsif has_button?(button)
    click_button button
  else
    find("input[type='submit'][value='#{button.capitalize}']").click
  end
end

And(/^I press "Check" button$/) do
  click_button 'Check'
end

# Step to navigate to a specific page
Given(/^I am on the "([^"]*)" page$/) do |page|
  visit path_to(page)
end

Then('I should see a set of different NGO buttons') do
  expect(page).to have_selector('.ngo_table')
end

When(/^I press the NGO "([^"]*)" card$/) do |image_alt|
  image = find("img[alt='#{image_alt} image']", wait: 10)
  card_link = image.find(:xpath, './/ancestor::a[@class="card-link"]')
  card_link.click
end

Then('I should be redirected to the "User Verification" page and see "EnableID Verification"') do
  puts current_path
  step 'I should see "EnableID Verification"'
end

Then(/^I should be redirected to the NGO "([^"]*)" page$/) do |page_name|
  $ngo_user = NgoUser.find_by(name: page_name)
  expect($ngo_user).not_to be_nil, "NgoUser with name #{page_name} not found."

  expected_path = "/ngo_users/#{$ngo_user.id}"
  expect(current_path).to eq(expected_path),
                          "Expected to be redirected to #{expected_path} but was at #{current_path} instead."
end

Then(/^I should see "([^"]*)"$/) do |name|
  expect(page).to have_content("#{name}")
end

Given(/^I am already on my NGO "([^"]*)" page$/) do |ngo_name|
  step 'I am on the "Login" page'
  step 'I press the "I am a NGO" button'
  step %(I press the NGO "#{ngo_name}" card)
  $ngo_user = NgoUser.find_by(name: ngo_name)
end

When(/^I key in the undocumented user's unique EnableID number: (\d+)$/) do |enable_id|
  fill_in 'unique_id', with: enable_id
end

And(%r{^I key in a 6 digit code that is seen on his/her EnableID: (\d{6})$}) do |code|
  fill_in 'two_fa_passcode', with: code
end

Then('I should see his\/her EnableID card') do
  expect(page).to have_selector('#digitalcard')
end

Then(/^I should see "([^"]*)" button$/) do |button_text|
  expect(page).to have_selector(".btn[value='#{button_text}']")
end

Given(/^I have a verified user (\d+) by NGO: (.+)$/) do |user_id, ngo_name|
  @user = create(:user, id: user_id, verified_by_ngo: ngo_name)
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
  expect(page).to have_content('Signed in successfully.')
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
