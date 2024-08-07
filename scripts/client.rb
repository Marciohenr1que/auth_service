require 'grpc'
require_relative '../lib/auth_service_pb'
require_relative '../lib/auth_service_services_pb'
require_relative '../app/services/auth_service'
require_relative '../app/services/user_authentication_service'
require_relative '../app/services/json_web_token'  # Adicione esta linha

class AuthService < Auth::AuthService::Service
  def validate_token(token_request, _unused_call)
    token = token_request.token
    puts "Recebido token: #{token}"
    
    # Lógica para validar o token
    begin
      decoded_token = Auth::TokenExtractHelper.decode(token)
      valid = decoded_token.present?
      user_id = valid ? decoded_token[:user_id] : ""
    rescue => e
      valid = false
      user_id = ""
    end

    Auth::TokenResponse.new(valid: valid, user_id: user_id)
  end
end

def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(AuthService.new)
  s.run_till_terminated
end

main

