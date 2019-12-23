class AccountPolicy < ApplicationPolicy
  def update?
    user.account_admin
  end

  def new_user?
    update?
  end
end
