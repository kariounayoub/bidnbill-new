class AccountPolicy < ApplicationPolicy
  def new_user?
    user.account_admin
  end
end
