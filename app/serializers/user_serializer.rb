class UserSerializer
    def initialize(user)
      @user = user
    end
  
    def as_json(options = {})
      {
        id: @user.id,
        name: @user.name,
        email: @user.email
      }
    end
  end
  