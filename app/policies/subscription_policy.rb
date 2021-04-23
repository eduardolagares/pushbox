class SubscriptionPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user&.admin? || user&.client?
  end

  def show?
    user&.admin? || user&.client?
  end

  def create?
    user&.admin? || user&.client?
  end

  def update?
    user&.admin? || user&.client?
  end

  def destroy?
    user&.admin? || user&.client?
  end
end
