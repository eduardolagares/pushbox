class Notification < ApplicationRecord
  enum body_type: { html: 1, text: 2 }
  enum status: { new: 0, queued: 1, sent: 2, canceled: 3 }, _prefix: :status
  
  belongs_to :provider
  belongs_to :destiny, polymorphic: true
  belongs_to :parent, class_name: 'Notification', foreign_key: 'parent_id'
  has_many :dependents, class_name: 'Notification', foreign_key: 'parent_id'

  before_validation :fill_status, on: [:create]
  before_save :keep_schedule
  before_create :schedule

  validates_presence_of :body_type, :title
  
  private
  
  def fill_status
    self.status ||= :new
  end

  def keep_schedule
    return unless status_changed?
    Pushbox::Schedule.new(notification: self).cancel() if status == 'canceled'
  end

  def schedule
    Pushbox::Schedule.new(notification: self).queue()
  end
end
