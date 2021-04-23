class User < ApplicationRecord
  enum role: { client: 1, admin: 2 }

  validates :role, presence: true
  validates :name, presence: true

  before_create :generate_api_key

  def generate_api_key
    self.api_key = (0...8).map { (65 + rand(26)).chr }.join
  end
end
