class BillPolicy < ApplicationPolicy
  def index?
    user == record.first.client
  end

  def show?
    user == record.client
  end
end
