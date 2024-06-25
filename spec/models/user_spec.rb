require 'rails_helper'

RSpec.describe User, type: :model do
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
      ActiveRecord::Base.connection.execute('DELETE FROM users')
    end
  end
  
  it 'is valid with valid attributes' do
    user = User.new(username: 'testuser', email: 'test@example.com', password: 'testpassword',
    password_confirmation: 'testpassword')
    expect(user).to be_valid  # Checks if the user is valid
  end

  it 'is not valid without a username' do
    user = User.new(username: nil, email: 'test@example.com', password: 'testpassword',
    password_confirmation: 'testpassword')
    expect(user).to_not be_valid  # Checks if the user is not valid
  end

  it 'is not valid without an email' do
    user = User.new(username: 'testuser', email: nil, password: 'testpassword',
    password_confirmation: 'testpassword')
    expect(user).to_not be_valid  # Checks if the user is valid
  end

  it 'is not valid without password' do
    user = User.new(username: 'testuser', email: 'test@example.com')
    expect(user).to_not be_valid  # Checks if the user is not valid
  end

  it 'is not valid with a duplicate username' do
    User.create(username: 'testuser1', email: 'test1@example.com', password: 'testpassword',
    password_confirmation: 'testpassword')
    user = User.new(username: 'testuser1', email: 'test2@example.com', password: 'testpassword',
    password_confirmation: 'testpassword')
    expect(user).to_not be_valid  # Checks if the user is not valid due to duplicate email
  end

  it 'is not valid with a duplicate email' do
    User.create(username: 'testuser1', email: 'test@example.com', password: 'testpassword',
    password_confirmation: 'testpassword')
    user = User.new(username: 'testuser2', email: 'test@example.com', password: 'testpassword',
    password_confirmation: 'testpassword')
    expect(user).to_not be_valid  # Checks if the user is not valid due to duplicate email
  end
end
