class UserPolicy < ApplicationPolicy
  def client_dashboard?
    user.user_type == 'client'
  end

  def provider_dashboard?
    user.user_type == 'provider'
  end
end
