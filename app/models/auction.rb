class Auction < ApplicationRecord
  belongs_to :bill
  has_one :category, through: :bill
  has_one :client, through: :bill
  has_many :accounts, through: :bids
  has_many :bids
end
