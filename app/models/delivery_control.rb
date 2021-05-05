class DeliveryControl < ApplicationRecord
  enum status: { unknown: 0, enqueued: 1, finished: 2, canceled: 3 }, _prefix: :status
  belongs_to :notification
  belongs_to :provider

  after_save :update_provider_identifiers_count
  before_create :create_job
  after_destroy :delete_job
  after_update :delete_job, if: proc { status_changed? && status == 'canceled' }
  
  validates :schedule_at, presence: true

  scope :pending, -> { where(status: [:enqueued]) }

  private

  def update_provider_identifiers_count
    self.provider_identifiers_count = provider_identifiers.size
  end

  def create_job
    job = SendingNotificationJob.set(wait_until: notification.schedule_at).perform_later(delivery_control_id: delivery_control.id)
    self.job_id = job.job_id
    self.status = :enqueued
  end

  def delete_job
    SendingNotificationJob.delete_if_exists(job_id: job_id)
  end
end
