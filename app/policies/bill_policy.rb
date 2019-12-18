class BillPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    record.client == user && user.is_valid
  end

  def my_bills?
    record.first == nil || user == record.first.client && user.is_valid
  end

  def show?
    user == record.client && user.is_valid
  end
end
