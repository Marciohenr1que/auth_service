class UserRepository
    def self.find_by_email(email)
      User.find_by(email: email)
    end
  
    def self.find_by_id(id)
      User.find(id)
    end
  end
  