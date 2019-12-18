class BidPolicy < ApplicationPolicy
  def my_clients?
    record.first == nil || user == record.first.user && user.is_valid
  end

  def create?
    record.user.account == user.account && user.is_valid
  end

  def update?
    create?
  end

  def select?
    record.bill.client == user && user.is_valid
  end
end
