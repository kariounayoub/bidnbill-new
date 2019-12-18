class NotificationPolicy < ApplicationPolicy
  def seen?
    record.user == user && user.is_valid
  end
end
