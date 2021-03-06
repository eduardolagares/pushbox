module ApiKeyGenerator
  extend ActiveSupport::Concern

  included do
    after_initialize :generate_api_key
  end

  def generate_api_key
    self.api_key ||= SecureRandom.alphanumeric(32)
  end
end
