class UserParticular < ActiveRecord::Base    
    def self.create_and_return_id(attributes)
        user_particular = UserParticular.create(attributes)
        user_particular.id
    end

    def self.find_by_id(user_particular_id)
        UserParticular.find_by(id: user_particular_id)
    end
      
end