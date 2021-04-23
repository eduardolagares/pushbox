class NotificationPolicy < ApplicationPolicy
  attr_reader :user, :record
  def create?
    user&.admin?
  end
end
