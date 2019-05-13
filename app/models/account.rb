class Account < ApplicationRecord
  has_many :account_categories, dependent: :destroy
  has_many :users
end
