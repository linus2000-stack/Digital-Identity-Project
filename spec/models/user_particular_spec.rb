require 'rails_helper'

RSpec.describe UserParticular, type: :model do
  # Seed the database before running any tests,
  # and roll back once all tests are finished
  before(:all) do
    ActiveRecord::Base.transaction do
      Rails.application.load_seed
      @seeded = true
    end
  end

  # Rollback transaction after each test case
  around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  # Rollback the seeding after all tests are done
  after(:all) do
    if @seeded
      ActiveRecord::Base.connection.execute('DELETE FROM user_particulars')
    end
  end

  describe '.create_and_return_id' do
    it 'creates a new user particular and returns its ID' do
      attributes = {
        full_name: 'Test User',
        phone_number: '555-555-5555'
      }
      user_particular_id = UserParticular.create_and_return_id(attributes)
      expect(user_particular_id).not_to be_nil
      expect(UserParticular.find_by_id(user_particular_id)).to have_attributes(attributes)
    end
  end

  describe '.find_by_id' do
    it 'returns the user particular with the specified ID' do
      attributes = {
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
      }

      # Find the first user particular to ensure it exists
      user_particular = UserParticular.first
      expect(user_particular).not_to be_nil

      found_user_particular = UserParticular.find_by_id(user_particular.id)
      expect(found_user_particular.attributes.except('id', 'created_at', 'updated_at').symbolize_keys).to eq(attributes)
    end

    it 'returns nil if no user particular with the specified ID is found' do
      found_user_particular = UserParticular.find_by_id(999999) # Assuming there's no user particular with ID 999999
      expect(found_user_particular).to be_nil
    end
  end
end
