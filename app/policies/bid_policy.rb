class BidPolicy < ApplicationPolicy
  def my_clients?
    record.first == nil || user == record.first.user
  end
end
