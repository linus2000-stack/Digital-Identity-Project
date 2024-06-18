class UserParticulars < ActiveRecord::Base
    def self.first_user_particulars
        first
    end

    def self.last_user_particulars
        last
    end    
end