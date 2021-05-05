module Pushbox
  class Schedule
    attr_accessor :notification
    def initialize(notification:)
      raise RuntimeError, 'notification param should be a instance of the Notification model.' unless notification.instance_of?(Notification)
      self.notification = notification
    end

    def cancel
      check_transaction()
      raise RuntimeError, 'Is only possible to cancel jobs for a sending notification.' unless notification.status_sending?
      notification.delivery_controls.each do |delivery_control|
        delivery_control.status = :canceled
        delivery_control.save!
      end
      notification.status = :canceled
      notification.save!
    end

    def queue
      check_transaction()
      raise RuntimeError, 'Is only possible to create jobs for a new notification.' unless notification.status_new?
      case notification.destiny.class
        when Device
          schedule_device(device: notification.destiny)
        when Topic
          schedule_topic(topic: notification.destiny)
        else
          raise RuntimeError, "Is not possible to create jobs for a #{notification.destiny.class} destiny."
      end
    end

    private
    def check_transaction
      raise RuntimeError, 'Schedule should be used inside a database transaction.' unless ActiveRecord::Base.connection.transaction_open?
    end

    def schedule_device(device:)
      raise RuntimeError, 'device param should be a instance of the Device model.' unless device.instance_of?(Device)
      DeliveryControl.create!(notification: notification, provider_id: device.provider_id, provider_identifiers: [device.provider_identifier])
    end

    def schedule_topic(topic:)
      raise RuntimeError, 'topic param should be a instance of the Topic model.' unless topic.instance_of?(Topic)
      topic.devices.group(:provider_id).pluck(:provider_identifier).each do |provider_id, provider_identifiers|
        provider = Provider.select(:device_class_name).find(provider_id)
        provider_identifiers.chunk(provider.max_devices_per_request) do |chunk_of_provider_identifiers|
          DeliveryControl.create!(notification: notification, provider_id: device.provider_id, provider_identifiers: chunk_of_provider_identifiers)
        end
      end
    end
  end
end