class BidPolicy < ApplicationPolicy
  def my_clients?
    record.first == nil || user.account == record.first.user.account
  end

  def lost_bills?
    my_clients?
  end

  def create?
    record.user.account == user.account
  end

  def update?
    create?
  end

  def select?
    record.bill.client == user
  end
end
