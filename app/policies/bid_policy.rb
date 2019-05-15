class BidPolicy < ApplicationPolicy
  def my_clients?
    record.first == nil || user == record.first.user
  end

  def create?
    record.user.account == user.account
  end

  def select?
    record.bill.client == user
  end
end
