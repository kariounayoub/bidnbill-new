class Account < ApplicationRecord
  has_many :account_categories, dependent: :destroy
  has_many :users

  mount_base64_uploader :picture, PhotoUploader

end
