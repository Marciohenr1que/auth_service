require 'grpc'
require_relative '../lib/notifications_services_pb'

class NotificationClient
  def initialize
    # Substitua pelo endereço e porta corretos do seu microserviço de notificações
    @stub = Notifications::NotificationService::Stub.new('localhost:50052', :this_channel_is_insecure)
  end

  def send_notification(action:, user_name:, user_id:, user_email:, task_id:, task_title:, task_description:)
    request = Notifications::NotificationRequest.new(
      action: action,
      user_name: user_name,
      user_id: user_id,
      user_email: user_email,
      task_id: task_id,
      task_title: task_title,
      task_description: task_description
    )
    # Chama o método gRPC no servidor de notificações
    @stub.send_notification(request)
  end
end
