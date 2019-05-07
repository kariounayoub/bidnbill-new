class Category < ApplicationRecord
  has_many :bills
  has_many :account_categories
    CATEGORIES = ['Electricité', 'Gaz', 'Téléphonie', 'Box Internet']
  validates :name, presence: true
  validates :name, inclusion: {in: CATEGORIES}
end
