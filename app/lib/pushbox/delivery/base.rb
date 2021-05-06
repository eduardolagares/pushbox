module Pushbox
  module Delivery
    class Base
      attr_accessor :delivery
      def initialize(delivery:)
        raise RuntimeError, 'delivery param should be a instance of the Delivery model.' unless notification.instance_of?(Delivery)
        self.delivery = delivery
      end

      def deliver
        ActiveRecord::Base.transaction do
          notification = delivery.notification.lock()
          notification.status = :sending
          notification.save!
          send()
          delivery.status = :finished
          delivery.save!
          if notification.delivery.pending.count == 0
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