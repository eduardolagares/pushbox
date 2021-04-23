module ApiKeyGenerator
  extend ActiveSupport::Concern
  included do
    before_create :generate_api_key
  end

  def generate_api_key
    self.api_key = (0...26).map { rand(65..90).chr }.join
  end
end
