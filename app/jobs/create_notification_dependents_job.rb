class CreateNotificationDependentsJob < ApplicationJob
  queue_as :delivery_control

  def perform(notification_id:)
    ActiveRecord::Base.transaction do
      notification = Notification.find(notification_id).lock()
      return unless notification.status_new?
      notification.status = :waiting
      notification.save!
      
      notification.destiny.devices.merge(Subscription.not_canceled).find_in_batches(batch_size: 1000).map do |devices|
        Notification.insert_all devices.map do |device|
          {
            parent_id: notification.id,
            provider_id: notification.provider_id,
            schedule_at: notification.schedule_at,
            status: Notification.statuses[:waiting],
            destiny_type: 'Device',
            destiny_id: device.id
          }
        end
      end
    end
  end
end
