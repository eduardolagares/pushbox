module Pushbox
  module Delivery
    class Base
      attr_accessor :payload, :not_found_devices, :provider_id

      def initialize(notifications:, provider_id:)
        self.provider_id = provider_id
        if notifications.size > self.class.max_devices_per_request
          raise "The max number of notifications for a #{self.class.name} delivery is #{self.class.max_devices_per_request}"
        end

        fill_payload(notifications: notifications)
        self.not_found_devices = []
      end

      def run
        send
        not_found_devices.each do |device|
          Rails.logger.warn "Removing #{device.provider_identifier} from database because it wasn't found on #{device.provider.name} provider."
          device.destroy!
        end
      end

      def self.max_devices_per_request
        raise NotImplementError
      end

      def self.is_topic_suported?
        raise NotImplementError
      end

      private

      def fill_payload(notifications:)
        raise NotImplementError
      end

      def send
        raise NotImplementError
      end
    end
  end
end
