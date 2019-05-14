class Bid < ApplicationRecord
  belongs_to :bill
  belongs_to :user

  has_one :account, through: :user
  has_one :client, through: :bill


  before_create :init

  def init
    self.status  ||= "en attente"
  end

  STATUS = ["refusé","en attente", "accépté"]
end
