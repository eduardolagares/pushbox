class Topic < ApplicationRecord
  has_many :subscriptions, dependent: :delete_all
  has_many :devices, through: :subscriptions
  has_many :notifications, as: :destiny, dependent: :delete_all

  validates :title, presence: true

  scope :by_title, ->(title) { where('title like ?', "#{title}%") unless title.blank? }
end
