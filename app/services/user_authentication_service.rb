class UserAuthenticationService
    def initialize(email, password)
      @user = User.find_by(email: email)
      @password = password
    end
  
    def call
      if @user && @user.authenticate(@password)
        token = JsonWebToken.encode(user_id: @user.id)
        { success: true, token: token, user: @user }
      else
        { success: false, errors: ["Invalid email or password"] }
      end
    end
  end
  