class NotificationPolicy < ApplicationPolicy
  def seen?
    record.user == user
  end
end
