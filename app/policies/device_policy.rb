class DevicePolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user&.admin?
  end

  def show?
    user&.admin? || user&.id == record.id
  end

  def create?
    user&.kind_of?(User)
  end

  def update?
    user&.admin? || user&.id == record.id
  end

  def destroy?
    user&.admin?
  end

  def show_subscriptions?
    user&.admin? || user&.id == record.id
  end
end
