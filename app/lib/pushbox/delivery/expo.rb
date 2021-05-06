module Pushbox
  module Delivery
    class Expo < Pushbox::Delivery::Base

      def self.max_devices_per_request
        50
      end

      def self.is_topic_suported
        false
      end

      private
      def send
        # TODO: to use expo api here
        puts 'FAKE SENDING...'
      end
    end
  end
end