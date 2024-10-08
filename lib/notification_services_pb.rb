# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: notification.proto for package 'notification'

require 'grpc'
require_relative '../lib/notification_pb'

module Notification
  module NotificationService
    class Service

      include ::GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'notification.NotificationService'

      rpc :SendNotification, ::Notification::NotificationRequest, ::Notification::NotificationResponse
      rpc :SendWebscrapingNotification, ::Notification::WebscrapingNotificationRequest, 
          ::Notification::NotificationResponse
    end

    Stub = Service.rpc_stub_class
  end
end
