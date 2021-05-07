class SendingNotificationJob < ApplicationJob
  queue_as :delivery

  def perform(provider_id:)
    delivery = Provider.find(provider_id)
    delivery_class = provider.delivery_class()
    delivery = delivery_class.new()
    delivery.deliver()
  end
end
