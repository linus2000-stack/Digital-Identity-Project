seed_user_particulars = [
  { full_name: 'John Doe', phone_number: '123-456-7890' },
  { full_name: 'Jane Smith', phone_number: '987-654-3210' },
  { full_name: 'Alice Johnson', phone_number: '555-555-5555' },
  { full_name: 'Bob Anderson', phone_number: '111-222-3333' },
  { full_name: 'Emma Davis', phone_number: '444-444-4444' }
]

seed_user_particulars.each do |user_particular|
  UserParticular.create!(user_particular)
end