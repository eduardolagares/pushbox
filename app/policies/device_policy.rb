class DevicePolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user&.admin?
  end

  def show?
    user&.admin? || user&.client?
  end

  def create?
    user&.client?
  end

  def update?
    user&.client?
  end

  def destroy?
    user&.admin?
  end
end
