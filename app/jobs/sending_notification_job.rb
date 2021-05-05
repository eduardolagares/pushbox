class SendingNotificationJob < ApplicationJob
  queue_as :delivery_notification

  def perform(delivery_control_id:)
    delivery_control = DeliveryControl.find(delivery_control_id)
    delivery_class = delivery_control.delivery_class()
    delivery = delivery_class.new(delivery_control: delivery_control)
    delivery.deliver()
  end
end
