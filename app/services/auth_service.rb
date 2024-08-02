require 'grpc'
require_relative '../services/user_authentication_service'

class AuthService < Auth::AuthService::Service
  def validate_token(request, _unused_call)
    decoded_token = JsonWebToken.decode(request.token)
    if decoded_token
      user_id = decoded_token[:user_id]
      Auth::TokenResponse.new(valid: true, user_id: user_id)
    else
      Auth::TokenResponse.new(valid: false)
    end
  end
end
