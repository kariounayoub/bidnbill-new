class UserPolicy < ApplicationPolicy
  def client_dashboard?
    record.user_type == 'client' && user == record
  end

  def provider_dashboard?
    record.user_type == 'provider' && user == record
  end

  def update?
    record == user
  end

  def disable_user?
    record.account == user.account && user.account_admin && record != user
  end
end
