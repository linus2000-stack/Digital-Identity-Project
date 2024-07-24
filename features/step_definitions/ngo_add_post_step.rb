# Given I am already on the NGO "Gebirah" page
Given(/^I am already on the NGO "(.*?)" page$/) do |ngo_name|
  # Assuming you have a method to find the NGO user by name and get its ID
  # ngo_user = NgoUser.find_by(name: ngo_name)
  # visit ngo_user_path(ngo_user)

  # If you're using IDs directly and "Gebirah" corresponds to a specific ID, e.g., 6
  ngo_user_id = 6 # You would dynamically fetch this based on `ngo_name` in a real app
  visit ngo_user_path(ngo_user_id)
end

