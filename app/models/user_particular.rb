class UserParticular < ActiveRecord::Base
  belongs_to :user
  before_create :assign_unique_id, :generate_2fa_secret

  def self.create_user_particular(attributes)
    UserParticular.create(attributes)
  end

  def self.find_by_id(id)
    UserParticular.find_by(id:)
  end

  def self.update_user_particular(id, attributes)
    user_particular = UserParticular.find_by(id:)
    user_particular.update(attributes)
    user_particular
  end

  def assign_unique_id
    self.unique_id = generate_unique_id
  end

  def generate_unique_id
    loop do
      unique_id = rand(1_000_000..9_999_999)
      return unique_id unless UserParticular.exists?(unique_id:)
    end
  end

  def generate_2fa_secret
    self.two_fa_passcode = rand(100_000..999_999)
  end
end
