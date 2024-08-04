require 'grpc'
require_relative '../lib/notification_services_pb'

class NotificationClient 
  def initialize
    @stub = Notification::NotificationService::Stub.new('localhost:50052', :this_channel_is_insecure)
  end

  def send_notification(action:, user_id:, user_email:, task_id:, task_title:, task_description:)
    request = Notification::NotificationRequest.new(
      action: action,
      user_id: user_id.to_s, 
      user_email: user_email,
      task_id: task_id.to_s,
      task_title: task_title,
      task_description: task_description
    )
    @stub.send_notification(request)
  end
end