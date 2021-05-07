class Subscription < ApplicationRecord
  belongs_to :topic
  belongs_to :device

  scope :not_canceled, -> { where(canceled: false) }
end
