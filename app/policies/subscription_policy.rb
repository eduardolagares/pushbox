class SubscriptionPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user&.admin? || user.is_a?(Device)
  end

  def show?
    user&.admin? || user&.id == record.device_id
  end

  def create?
    user&.admin? || user&.id == record.device_id
  end

  def update?
    user&.admin? || user&.id == record.device_id
  end

  def destroy?
    user&.admin? || user&.id == record.device_id
  end
end
