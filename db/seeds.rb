require 'date'

seed_user_particulars = [
  { 
    full_name: 'Rohingya Aung', 
    phone_number: '111-222-3333',
    secondary_phone_number: '555-555-5555',
    country_of_origin: 'Myanmar',
    ethnicity: 'Rohingya',
    religion: 'Muslim',
    gender: 'Male',
    date_of_birth: Date.new(1990, 3, 25),
    date_of_arrival: Date.new(2017, 9, 10),
    photo_url: 'https://example.com/rohingya_aung_photo.jpg',
    birth_certificate_url: 'https://example.com/rohingya_aung_birth_certificate.jpg',
    passport_url: 'https://example.com/rohingya_aung_passport.jpg'
  },
  #no secondary phone number
  { 
    full_name: 'Fatima Ali', 
    phone_number: '444-555-6666',
    country_of_origin: 'Iraq',
    ethnicity: 'Kurdish',
    religion: 'Muslim',
    gender: 'Female',
    date_of_birth: Date.new(1985, 12, 18),
    date_of_arrival: Date.new(2010, 5, 20),
    photo_url: 'https://example.com/fatima_ali_photo.jpg',
    birth_certificate_url: 'https://example.com/fatima_ali_birth_certificate.jpg',
    passport_url: 'https://example.com/fatima_ali_passport.jpg'
  },
  #no birth_certificate_url and passport_url
  { 
    full_name: 'Ahmed Khalid', 
    phone_number: '777-888-9999',
    secondary_phone_number: '555-555-5555',
    country_of_origin: 'Syria',
    ethnicity: 'Arab',
    religion: 'Muslim',
    gender: 'Male',
    date_of_birth: Date.new(1992, 7, 3),
    date_of_arrival: Date.new(2015, 2, 10),
    photo_url: 'https://example.com/ahmed_khalid_photo.jpg',
  },
  { 
    full_name: 'Phyu Phyu Win', 
    phone_number: '123-456-7890',
    secondary_phone_number: '555-123-4567',
    country_of_origin: 'Myanmar',
    ethnicity: 'Burmese',
    religion: 'Buddhist',
    gender: 'Female',
    date_of_birth: Date.new(1988, 5, 12),
    date_of_arrival: Date.new(2012, 8, 15),
    photo_url: 'https://example.com/phyu_phyu_win_photo.jpg',
    birth_certificate_url: 'https://example.com/phyu_phyu_win_birth_certificate.jpg',
    passport_url: 'https://example.com/phyu_phyu_win_passport.jpg'
  },
  { 
    full_name: 'Hussein Abbas', 
    phone_number: '555-666-7777',
    secondary_phone_number: '010-814-4567',
    country_of_origin: 'Iraq',
    ethnicity: 'Arab',
    religion: 'Muslim',
    gender: 'Male',
    date_of_birth: Date.new(1995, 10, 7),
    date_of_arrival: Date.new(2018, 4, 22),
    photo_url: 'https://example.com/hussein_abbas_photo.jpg',
    birth_certificate_url: 'https://example.com/hussein_abbas_birth_certificate.jpg',
    passport_url: 'https://example.com/hussein_abbas_passport.jpg'
  },
]

seed_user_particulars.each do |user_particular|
  UserParticular.create!(user_particular)
end
