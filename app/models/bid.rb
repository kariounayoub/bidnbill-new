class Bid < ApplicationRecord
  STATUS = ["refusé", "en attente", "accépté"]
  belongs_to :bill
  belongs_to :user

  has_one :account, through: :user
  has_one :client, through: :bill

  validates :status, inclusion: {in: STATUS}
  validates :status, :price, presence: true

  before_validation(on: :create) do
    self.status  ||= "en attente"
    self.bill.update(send_update_email: true)
  end

end
