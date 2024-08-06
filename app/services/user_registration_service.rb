class UserRegistrationService
    def initialize(user_params)
      @user_params = user_params
    end
  
    def call
      user = User.new(@user_params)
      user.unique_id = SecureRandom.uuid
      if user.save
        { success: true, user: user }
      else
        { success: false, errors: user.errors.full_messages }
      end
    end
  end
  