class Topic < ApplicationRecord
  has_many :subscriptions

  validates :title, presence: true

  scope :by_title, ->(title) { where('title like ?', "#{title}%") unless title.blank? }
end
