class Device < ApplicationRecord
  belongs_to :provider
  belongs_to :system

  validates :provider_identifier, uniqueness: { scope: :provider_id }
end
