class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  def self.delete_if_exists(job_id:)
    case Rails.configuration.active_job.queue_adapter
    when :sidekiq
      Sidekiq::ScheduledSet.new.find_job(job_id).try(:delete)
    else
      raise NotImplementError, "The delete_if_exists job command is not available for the \"#{Rails.configuration.active_job.queue_adapter.to_s}\" adapter."
    end
  end
end
