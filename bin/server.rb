
require 'grpc'
require_relative '../lib/auth_service_pb'
require_relative '../lib/auth_service_services_pb'
require_relative '../app/services/auth_service'
require_relative '../app/services/user_authentication_service'


def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(AuthService.new)
  s.run_till_terminated
end

main
