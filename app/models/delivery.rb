class Delivery < ApplicationRecord
  enum status: { unknown: 0, enqueued: 1, finished: 2, canceled: 3 }, _prefix: :status
  belongs_to :notification
  belongs_to :provider
  belongs_to :topic, optional: true
  has_and_belongs_to_many :devices


  before_create :create_job
  after_destroy :delete_job
  after_update :delete_job, if: proc { status_changed? && status == 'canceled' }
  
  validates :schedule_at, presence: true

  scope :pending, -> { where(status: [:enqueued]) }

  private

  def create_job
    job = SendingNotificationJob.set(wait_until: notification.schedule_at).perform_later(delivery_id: delivery.id)
    self.job_id = job.job_id
    self.status = :enqueued
  end

  def delete_job
    SendingNotificationJob.delete_if_exists(job_id: job_id)
  end
end
