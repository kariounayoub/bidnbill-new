class BillPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    record.client == user
  end

  def my_bills?
    record.first == nil || user == record.first.client
  end

  def show?
    user == record.client
  end

  def create?
    user == record.client
  end
end
