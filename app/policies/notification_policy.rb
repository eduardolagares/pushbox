class NotificationPolicy < ApplicationPolicy
  attr_reader :user, :device, :record

  def list?
    user&.admin? || (user&.client? && !device.nil?)
  end

  def create?
    user&.admin?
  end

  def read?
    record.destiny == device
  end
end
