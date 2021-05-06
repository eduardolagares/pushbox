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
      notification.Deliveries.each do |delivery|
        delivery.status = :canceled
        delivery.save!
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
      delivery = Delivery.create!(notification: notification, provider_id: device.provider_id)
      delivery.devices << device
    end

    def schedule_topic(topic:)
      raise RuntimeError, 'topic param should be a instance of the Topic model.' unless topic.instance_of?(Topic)
      topic.devices.group(:provider_id).pluck(:id).each do |provider_id, device_ids|
        provider = Provider.select(:device_class_name).find(provider_id)
        device_ids.chunk(provider.max_devices_per_request) do |chunk_of_device_ids|
          delivery = Delivery.new(notification: notification, provider_id: device.provider_id)
          delivery.device_ids = chunk_of_device_ids
          delivery.save!
        end
      end

      # TODO: suportar topic que para providers que tenham suporte nativo.
      # O problema aqui é que cada provider teria seu proprio "id", trazendo a necessidade de uma nova tabela.
      
    end
  end
end