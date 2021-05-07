class Subscription < ApplicationRecord
  belongs_to :topic
  belongs_to :device
  
  after_initialize :default_values

  validates :device, presence: true, uniqueness: { scope: :topic_id , message: "is already subscribed in this topic."}
  validates :topic, presence: true

  scope :not_canceled, -> { where(canceled: false) }

  private

  def default_values
    self.canceled ||= false
  end
end
