class CreateNotificationDependentsJob < ApplicationJob
  queue_as :delivery_control

  def perform(notification_id:)
    ActiveRecord::Base.transaction do
      notification = Notification.lock.find(notification_id)
      return unless notification.status_new?
      return unless notification.destiny.instance_of?(Topic)
      notification.destiny.devices.merge(Subscription.not_canceled).find_in_batches(batch_size: 1000).each do |devices|
        current_time = Time.current

        Notification.insert_all!(devices.map { |device|
          {
            parent_id: notification.id,
            provider_id: notification.provider_id,
            schedule_at: notification.schedule_at,
            status: Notification.statuses[:queued],
            destiny_type: 'Device',
            destiny_id: device.id,
            created_at: current_time,
            updated_at: current_time,
          }
        })
      end
      notification.status = :queued
      notification.save!
    end
  end
end
