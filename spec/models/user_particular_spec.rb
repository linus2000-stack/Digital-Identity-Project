require 'rails_helper'

RSpec.describe UserParticular, type: :model do
  # Seed the database before running any tests
  before(:all) do
    Rails.application.load_seed
  end

  # Rollback transaction after each test case
  around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  describe '.first_user_particulars' do
    it 'returns the first user particulars in the database' do
      user = UserParticular.first_user_particulars
      expect(user).to have_attributes(full_name: 'John Doe', phone_number: '123-456-7890')
    end
  end

  describe '.last_user_particulars' do
    it 'returns the last user particulars in the database' do
      user = UserParticular.last_user_particulars
      expect(user).to have_attributes(full_name: 'Emma Davis', phone_number: '444-444-4444')
    end
  end
end
