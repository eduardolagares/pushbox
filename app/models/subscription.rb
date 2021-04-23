class Subscription < ApplicationRecord
  belongs_to :topic
  belongs_to :device

  scope :not_canceled, -> { where(canceled: false) }

  enum status: { synced: 1, waiting_for_sync: 2 }

  validates :status, presence: true
end
