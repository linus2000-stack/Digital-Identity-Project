require 'date'

user1 = User.create!(
  username: 'user1',
  email: 'user1@mail.com',
  password: 'password1',
  password_confirmation: 'password1',
  phone_number: '90000001'
)

user1.create_user_particular!(
  full_name: 'Rohingya Aung',
  phone_number_country_code: '+60',
  phone_number: '111-222-3333',
  secondary_phone_number_country_code: '+60',
  secondary_phone_number: '555-555-5555',
  full_phone_number: '60111-222-3333',
  country_of_origin: 'Myanmar',
  ethnicity: 'Rohingya',
  religion: 'Islam',
  gender: 'Male',
  date_of_birth: Date.new(1990, 3, 25),
  date_of_arrival: Date.new(2017, 9, 10),
  photo_url: 'https://example.com/rohingya_aung_photo.jpg',
  birth_certificate_url: 'https://example.com/rohingya_aung_birth_certificate.jpg',
  passport_url: 'https://example.com/rohingya_aung_passport.jpg',
  status:'pending'
)

user2 = User.create!(
  username: 'user2',
  email: 'user2@mail.com',
  password: 'password2',
  password_confirmation: 'password2',
  phone_number: '90000002'
)

# User particular: no secondary phone number
user2.create_user_particular!(
  full_name: 'Fatima Ali',
  phone_number_country_code: '+60',
  phone_number: '444-555-6666',
  secondary_phone_number_country_code: '+60',
  secondary_phone_number: '111-222-333',
  full_phone_number: '60444-555-6666',
  country_of_origin: 'Iraq',
  ethnicity: 'Kurdish',
  religion: 'Islam',
  gender: 'Female',
  date_of_birth: Date.new(1985, 12, 18),
  date_of_arrival: Date.new(2010, 5, 20),
  photo_url: 'https://example.com/fatima_ali_photo.jpg',
  birth_certificate_url: 'https://example.com/fatima_ali_birth_certificate.jpg',
  passport_url: 'https://example.com/fatima_ali_passport.jpg',
  status:'pending'
)

user3 = User.create!(
  username: 'user3',
  email: 'user3@mail.com',
  password: 'password3',
  password_confirmation: 'password3',
  phone_number: '90000003'
)

# User particular: no birth_certificate_url and passport_url
user3.create_user_particular!(
  full_name: 'Ahmed Khalid',
  phone_number_country_code: '+60',
  phone_number: '777-888-9999',
  secondary_phone_number_country_code: '+60',
  secondary_phone_number: '555-555-5555',
  full_phone_number: '60777-888-9999',
  country_of_origin: 'Syria',
  ethnicity: 'Arab',
  religion: 'Islam',
  gender: 'Male',
  date_of_birth: Date.new(1992, 7, 3),
  date_of_arrival: Date.new(2015, 2, 10),
  photo_url: 'https://example.com/ahmed_khalid_photo.jpg',
  status:'pending'
)

user4 = User.create!(
  username: 'user4',
  email: 'user4@mail.com',
  password: 'password4',
  password_confirmation: 'password4',
  phone_number: '90000004'
)

user4.create_user_particular!(
  full_name: 'Phyu Phyu Win',
  phone_number_country_code: '+60',
  phone_number: '123-456-7890',
  secondary_phone_number_country_code: '+60',
  secondary_phone_number: '555-123-4567',
  full_phone_number: '60123-456-7890',
  country_of_origin: 'Myanmar',
  ethnicity: 'Burmese',
  religion: 'Buddhism',
  gender: 'Female',
  date_of_birth: Date.new(1988, 5, 12),
  date_of_arrival: Date.new(2012, 8, 15),
  photo_url: 'https://example.com/phyu_phyu_win_photo.jpg',
  birth_certificate_url: 'https://example.com/phyu_phyu_win_birth_certificate.jpg',
  passport_url: 'https://example.com/phyu_phyu_win_passport.jpg',
  status:'pending'
)

user5 = User.create!(
  username: 'user5',
  email: 'user5@mail.com',
  password: 'password5',
  password_confirmation: 'password5',
  phone_number: '90000005'
)

user5.create_user_particular!(
  full_name: 'Hussein Abbas',
  phone_number_country_code: '+60',
  phone_number: '555-666-7777',
  secondary_phone_number_country_code: '+60',
  secondary_phone_number: '010-814-4567',
  full_phone_number: '60555-666-7777',
  country_of_origin: 'Iraq',
  ethnicity: 'Arab',
  religion: 'Islam',
  gender: 'Male',
  date_of_birth: Date.new(1995, 10, 7),
  date_of_arrival: Date.new(2018, 4, 22),
  photo_url: 'https://example.com/hussein_abbas_photo.jpg',
  birth_certificate_url: 'https://example.com/hussein_abbas_birth_certificate.jpg',
  passport_url: 'https://example.com/hussein_abbas_passport.jpg',
  status:'pending'
)

ngo_users = [
  { name: 'CARE International', image_url: 'care.png' },
  { name: 'Amnesty International', image_url: 'AmnestyInternational.png' },
  { name: 'Oxfam', image_url: 'oxfam.png' },
  { name: 'World Vision', image_url: 'worldvision.png' },
  { name: 'Human Rights Watch', image_url: 'humanrightswatch.png' },
  { name: 'Gebirah', image_url: 'Gebirah.png' },
  { name: 'International Rescue Committee (IRC)', image_url: 'IRC.png' },
  { name: 'Doctors Without Borders/Médecins Sans Frontières', image_url: 'MSF.png' },
  { name: 'Norwegian Refugee Council (NRC)', image_url: 'NRC.png' },
  { name: 'Save the Children', image_url: 'Savethechildren.png' },
  { name: 'UNHCR', image_url: 'unhcr.png' },
  { name: 'World Relief', image_url: 'world relief.png' }
]

# Creating each NgoUser from the array
ngo_users.each do |ngo|
  ngo_user = NgoUser.find_or_initialize_by(name: ngo[:name])
  ngo_user.update!(image_url: ngo[:image_url])
end
