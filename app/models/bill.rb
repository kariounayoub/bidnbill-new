class Bill < ApplicationRecord
  FREQUENCY = ['mensuelle', 'semestrielle', 'annuelle']

  belongs_to :client, class_name: 'User', foreign_key: 'user_id'
  belongs_to :category
  has_many :bids
  has_many :accounts, through: :bids

  validates :current_provider, :price, :consumption, :address, :payment_frequency, presence: true

  validates :payment_frequency, inclusion: {in: FREQUENCY}

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  before_create :set_open

  def set_open
    self.is_open = true
  end
end
