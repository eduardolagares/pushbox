module Pushbox
  module Delivery
    class Base
      attr_accessor :delivery_control
      def initialize(delivery_control:)
        raise RuntimeError, 'delivery_control param should be a instance of the DeliveryControl model.' unless notification.instance_of?(DeliveryControl)
        self.delivery_control = delivery_control
      end

      def deliver
        ActiveRecord::Base.transaction do
          notification = delivery_control.notification.lock()
          notification.status = :sending
          notification.save!
          send()
          delivery_control.status = :finished
          delivery_control.save!
          if notification.delivery_control.pending.count == 0
            notification.status = :finished
            notification.save!
          end
        end
      end

      def self.max_devices_per_request
        raise NotImplementError
      end

      def self.is_topic_suported
        raise NotImplementError
      end
      
      private
      def send
        raise NotImplementError
      end
    end
  end
end