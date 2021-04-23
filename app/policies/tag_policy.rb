class TagPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user&.admin? ||user&.client?
  end

  def show?
    user&.admin? ||user&.client?
  end

  def create?
    user&.admin?
  end

  def update?
    user&.admin?
  end

  def destroy?
    user&.admin?
  end
end
