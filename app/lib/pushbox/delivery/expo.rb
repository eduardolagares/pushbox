module Pushbox
  module Delivery
    class Expo < Pushbox::Delivery::Base

      def self.max_devices_per_request
        5
      end

      def self.is_topic_suported
        false
      end

      def fill_payload(notifications:)
        self.payload ||= []
        notifications.each do |notification|
          self.payload << {
            to: notification.destiny.provider_identifier,
            sound: 'default',
            title: notification.title || '',
            body: notification.body || '',
            data: notification.data || {}
          }
        end
        self.payload
      end

      def send
        client = Exponent::Push::Client.new(gzip: true)
        handler = client.send_messages(self.payload)
        handler.invalid_push_tokens.each do |token|
          self.not_found_devices << Device.where(provider_id: self.provider_id, provider_identifier: token).take
        end
        handler.errors.each do |error|
          Rails.logger.warn error.message
        end
        # TODO: to implement message reading confirmation.
        # result = client.verify_deliveries(handler.receipt_ids)
      end

    end
  end
end

