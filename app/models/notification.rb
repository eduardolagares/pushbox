class Notification < ApplicationRecord
  enum body_type: { html: 1, text: 2 }
  enum status: { new: 0, queued: 1, sent: 2, canceled: 3 }, _prefix: :status
  
  belongs_to :provider
  belongs_to :destiny, polymorphic: true
  belongs_to :parent, class_name: 'Notification', foreign_key: 'parent_id', optional: true
  has_many :dependents, class_name: 'Notification', foreign_key: 'parent_id'

  after_initialize :default_values
  after_commit :create_dependents, on: [:create], if: proc { destiny.instance_of?(Topic) }

  validates_presence_of :body, if: proc { parent_id.nil? }
  validates_presence_of :body_type, if: proc { parent_id.nil? }
  validates_presence_of :title, if: proc { parent_id.nil? }

  def title
    return parent.title if parent_id.present?
    read_attribute(:title)
  end

  def subtitle
    return parent.subtitle if parent_id.present?
    read_attribute(:subtitle)
  end

  def body
    return parent.body if parent_id.present?
    read_attribute(:body)
  end

  def body_type
    return parent.body_type if parent_id.present?
    read_attribute(:body_type)
  end

  def data
    return parent.data if parent_id.present?
    read_attribute(:data)
  end

  def tag
    return parent.tag if parent_id.present?
    read_attribute(:tag)
  end

  private
  
  def default_values
    self.status ||= :new
    self.schedule_at ||= 5.minutes.from_now
  end

  def create_dependents
    return unless destiny.instance_of?(Topic)
    CreateNotificationDependentsJob.perform_later(notification_id: self.id)
  end
end
