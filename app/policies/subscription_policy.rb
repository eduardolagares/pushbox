class SubscriptionPolicy < ApplicationPolicy
  attr_reader :user, :device, :record

  def index?
    user&.admin? || !device.nil?
  end

  def show?
    user&.admin? || device&.id == record.device_id
  end

  def create?
    user&.admin? || device&.id == record.device_id
  end

  def update?
    user&.admin? || device&.id == record.device_id
  end

  def destroy?
    user&.admin? || device&.id == record.device_id
  end
end
