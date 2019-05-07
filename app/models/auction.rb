class Auction < ApplicationRecord
  belongs_to :bill
  has_one :category, through: :bill
  has_one :client, through: :bill
  has_many :bids
  has_many :accounts, through: :bids
end
