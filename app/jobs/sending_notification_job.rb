class SendingNotificationJob < ApplicationJob
  queue_as :delivery_notification

  def perform(delivery_id:)
    delivery = Delivery.find(delivery_id)
    delivery_class = delivery.delivery_class()
    delivery = delivery_class.new(delivery: delivery)
    delivery.deliver()
  end
end
