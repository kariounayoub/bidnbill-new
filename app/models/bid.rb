class Bid < ApplicationRecord
  belongs_to :bill
  belongs_to :user

  has_one :account, through: :user
  has_one :client, through: :bill


  before_create :init

  def init
    self.status  ||= "pending"
  end

  STATUS = ["cancelled","pending", "completed"]
  PAYMENT_STATUS = ["cancelled","pending", "completed"]
end
