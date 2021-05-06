class Topic < ApplicationRecord
  has_many :subscriptions
  has_many :devices, through: :subscriptions
  has_many :deliveries

  validates :title, presence: true

  scope :by_title, ->(title) { where('title like ?', "#{title}%") unless title.blank? }
end
