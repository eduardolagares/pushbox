class DevicePolicy < ApplicationPolicy
  attr_reader :user, :device, :record

  def index?
    user&.admin?
  end

  def show?
    user&.admin? || device&.id == record.id
  end

  def create?
    user
  end

  def update?
    user&.admin? || device&.id == record.id
  end

  def destroy?
    user&.admin?
  end

  def show_subscriptions?
    user&.admin? || device&.id == record.id
  end
end
