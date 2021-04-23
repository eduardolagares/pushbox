class User < ApplicationRecord
  include ApiKeyGenerator

  enum role: { client: 1, admin: 2 }

  validates :role, presence: true
  validates :name, presence: true
end
