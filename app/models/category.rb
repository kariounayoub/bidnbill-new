class Category < ApplicationRecord
  has_many :bills
  has_many :account_categories
    CATEGORIES = ['Electricité', 'Gas', 'Téléphonie', 'Internet', 'Electricité et Gas']
  validates :name, presence: true
  validates :name, inclusion: {in: CATEGORIES}
end
