class User < ApplicationRecord
  USERTYPE = ['client', 'provider']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :account, optional: true
  has_many :bills
  has_many :notifications

  validates :phone_number, format: { with: /((\+|00)33|0)\s*[1-9](?:[\s.-]*\d{2}){4}/}, allow_blank: true
  validates :user_type, inclusion: {in: USERTYPE}

  validate :validate_number_users

  mount_base64_uploader :picture, PhotoUploader

  def validate_number_users
    if user_type == 'provider'
      errors.add(:user, "vous avez dépassé le nombre d'utilisateurs autorisé") if account.users.size >= account.number_users_allowed
    end
  end

  def full_name
    "#{first_name} #{last_name}" unless first_name.nil? || last_name.nil?
  end
end
