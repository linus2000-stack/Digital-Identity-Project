seed_user_particulars = [
  { 
    full_name: 'John Doe', 
    phone_number: '123-456-7890',
    secondary_phone_number: '555-123-4567',
    country_of_origin: 'United States',
    ethnicity: 'Caucasian',
    religion: 'Christian',
    gender: 'Male',
    date_of_birth: '1990-01-01',
    date_of_arrival: '2020-01-01',
    photo_url: 'https://example.com/john_doe_photo.jpg',
    birth_certificate_url: 'https://example.com/john_doe_birth_certificate.jpg',
    passport_url: 'https://example.com/john_doe_passport.jpg'
  },
  { 
    full_name: 'Jane Smith', 
    phone_number: '987-654-3210',
    country_of_origin: 'Canada',
    ethnicity: 'Asian',
    religion: 'Buddhist',
    gender: 'Female',
    date_of_birth: '1995-03-15',
    date_of_arrival: '2018-05-20',
    photo_url: 'https://example.com/jane_smith_photo.jpg',
    birth_certificate_url: 'https://example.com/jane_smith_birth_certificate.jpg',
    passport_url: 'https://example.com/jane_smith_passport.jpg'
  },
]

seed_user_particulars.each do |user_particular|
  UserParticular.create!(user_particular)
end