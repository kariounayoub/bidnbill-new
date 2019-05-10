class BillPolicy < ApplicationPolicy
  def index?
    record.first == nil || user == record.first.client
  end

  def show?
    user == record.client
  end
end
