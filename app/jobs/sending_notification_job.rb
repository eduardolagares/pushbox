class SendingNotificationJob < ApplicationJob
  queue_as :delivery

  attr_accessor :notification_id

  def perform(notification_id:)
    self.notification_id = notification_id
    ActiveRecord::Base.transaction do
      notification = Notification.includes(:provider).where(id: notification_id).lock.take
      return if notification.nil?
      # Topic notifications can take a time to completes the CreateNotificationDependentsJob.
      return run_again_at(15.seconds.from_now) if notification.status_new?
      return unless notification.status_queued?

      case notification.destiny.class.name
      when 'Device'
        delivery_for_device(notification: notification)
      when 'Topic'
        delivery_for_topic(notification: notification)
      else
        raise NotImplementError,
              "SendingNotificationJob can't delivery notifications for a #{notification.destiny.class.name} destiny."
      end
    end
  end

  private

  def delivery_for_device(notification:)
    delivery_class = notification.provider.delivery_class()
    delivery = delivery_class.new(notifications: [notification], provider_id: notification.provider.id)
    delivery.run
    notification.status = :sent
    notification.save!
  end

  def delivery_for_topic(notification:)
    delivery_class = notification.provider.delivery_class()
    dependents = notification.dependents.status_queued.lock('FOR UPDATE SKIP LOCKED').limit(notification.provider.max_devices_per_request)
    delivery = delivery_class.new(notifications: dependents, provider_id: notification.provider.id)
    delivery.run
    dependents.update_all(status: :sent)
    # Is there anymore dependents notifications?
    if dependents.size >= notification.provider.max_devices_per_request
      # do it again.
      run_again_at(nil)
    else
      # the work is finished
      notification.status = :sent
      notification.save!
    end
  end

  def run_again_at(at)
    self.class.set(wait_until: at).perform_later(notification_id: notification_id)
  end
end
