class UserParticular < ActiveRecord::Base
  belongs_to :user

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
end
