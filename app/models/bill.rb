class Bill < ApplicationRecord
  belongs_to :client, class_name: 'User', foreign_key: 'user_id'
  belongs_to :category
  has_one :auction
  has_many :bids
  has_many :accounts, through: :bids


  validates :current_provider, :price, :consumption, :address, presence: true

  before_create :set_open


  def set_open
    self.is_open = true
  end
end
