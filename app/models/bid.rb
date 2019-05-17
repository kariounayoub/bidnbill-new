class Bid < ApplicationRecord
  belongs_to :bill
  belongs_to :user

  has_one :account, through: :user
  has_one :client, through: :bill


  before_create :init

  def init
    self.status  ||= "en attente"
    self.bill.update(send_update_email: true)
  end

  STATUS = ["refusé","en attente", "accépté"]
end
