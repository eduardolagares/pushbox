class Subscription < ApplicationRecord
  enum status: { synced: 1, waiting_for_sync: 2 }
  
  belongs_to :topic
  belongs_to :device

  validates :status, presence: true

  scope :not_canceled, -> { where(canceled: false) }
end
