class Topic < ApplicationRecord
  has_many :subscriptions

  validates :title, presence: true
end
