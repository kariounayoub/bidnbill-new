class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :user

  belongs_to :account, through: :user
  has_one :bill, through: :auction
  has_one :client, through: :auction


  after_initialize :init

  def init
    status  ||= "pending"
  end

  STATUS = ["cancelled","pending", "completed"]
  PAYMENT_STATUS = ["cancelled","pending", "completed"]
end
