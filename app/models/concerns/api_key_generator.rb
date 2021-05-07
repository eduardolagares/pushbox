module ApiKeyGenerator
  extend ActiveSupport::Concern
  included do
    before_create :generate_api_key
  end

  def generate_api_key
    self.api_key ||= SecureRandom.alphanumeric(32)
  end
end
