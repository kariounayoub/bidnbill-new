class Category < ApplicationRecord
  has_many :bills
  has_many :account_categories, dependent: :destroy
    CATEGORIES = ['Electricité', 'Gaz', 'Téléphonie', 'Internet', 'Electricité et Gaz']
  validates :name, presence: true
  validates :name, inclusion: {in: CATEGORIES}
end
