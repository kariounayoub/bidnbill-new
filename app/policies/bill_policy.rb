class BillPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def my_bills?
    record.first == nil || user == record.first.client
  end

  def show?
    user == record.client
  end
end
