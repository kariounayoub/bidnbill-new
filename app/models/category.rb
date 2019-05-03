class Category < ApplicationRecord
  has_many :bills
  has_many :account_categories
end
