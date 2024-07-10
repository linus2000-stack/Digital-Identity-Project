# Step to click a specific button
And(/^I press the "([^"]*)" button$/) do |button|
  click_link button
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

Then(/^I should be redirected to the NGO "([^"]*)" page$/) do |page_name|
  ngo_user = NgoUser.find_by(name: page_name)
  expect(ngo_user).not_to be_nil, "NgoUser with name #{page_name} not found."

  expected_path = "/ngo_users/#{ngo_user.id}"
  expect(current_path).to eq(expected_path),
                          "Expected to be redirected to #{expected_path} but was at #{current_path} instead."
end

Then(/^I should see "([^"]*)"$/) do |name|
  expect(page).to have_content("#{name}")
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
