module Pushbox
  class Schedule
    attr_accessor :notification
    def initialize(notification:)
      raise RuntimeError, 'notification param should be a instance of the Notification model.' unless notification.instance_of?(Notification)
      self.notification = notification
      self.notification.schedule_at ||= 10.minutes.from_now
    end

    def cancel
      check_transaction()
      raise RuntimeError, 'Is only possible to cancel jobs for a sending notification.' unless notification.status_queued?
    end

    def queue
      check_transaction()
      # raise RuntimeError, 'Is only possible to queue a notification for a new notification.'
      case notification.destiny.class.name
        when 'Device'
          queue_for_device(notification)
        when 'Topic'
          queue_for_topic(notification)
        else
          raise RuntimeError, "Is not possible to queue a notification for a #{notification.destiny.class} destiny."
      end
    end

    private
    def check_transaction
      raise RuntimeError, 'Schedule should be used inside a database transaction.' unless ActiveRecord::Base.connection.transaction_open?
    end

    def queue_for_device(notification)
      notification.status = :queued
      notification.save!
    end

    def queue_for_topic(notification)
      CreateNotificationDependentsJob.perform_later(notification_id: notification.id)
    end
  end
end